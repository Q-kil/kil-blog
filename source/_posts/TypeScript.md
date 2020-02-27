---
title: TypeScript
date: 2020-02-27 12:19:48
categories:
- TypeScript
tags:
- TypeScript
---

## Class
购物车功能
**Model**：购物车内商品item（商品，数量），购物车（商品item集合）
**View**：购物车模板
**Controller**: 购物车组件

### Model
#### cartItem.model.ts
``` ts
import { ICommodity } from '../mall/mall.model';
import { User } from "../user/user.model";

export class CartItem {
  private quantity: number;

  constructor(
    private _id: string,
    private checked: boolean,
    private commodity: ICommodity,
    private owner: User
  ) {
    this.quantity = 1;
  }

  get __id(): string { return this._id; }
  get _checked(): boolean { return this.checked; }
  get _commodity(): ICommodity { return this.commodity; }
  get _owner(): User { return this.owner; }

  // 数量的增减
  decreaseQuantity(): number {
    // service update
    this.cartService.update({
        commodity: this.commdity._id,
        checked: this.checked,
        quantity: --this.quantity
    }).subscribe(() => {
        return this.quantity; 
    })
  }
  increaseQuantity(): number { return this.quantity++; }

  // item 总价格
  get commodityTotal(): number { return this.quantity * this.commodity.price; }
}
```

#### cart.model.ts
``` ts
import { CartItem } from "./cartItem.model";

export class Cart {
  private content: Array<CartItem>;

  constructor() {
    this.content = new Array<CartItem>(); 
  }

  // 购物车中所有的商品
  getContent(): Array<CartItem> {
    return this.content;
  }

  // 选中的商品总价格
  get selectedTotal(): number {
    let total = 0;
    this.content.forEach((item) => {
      if (item._checked) {
        total += item.commodityTotal;
      }
    });
    return total;
  }

  addItem(item:CartItem) {
        let cartItem = new CartItem(item._id, item.checked, item.commodity, item.owner);
        let found:boolean = false;
        
        this._content.forEach(function(item) {
            // 判断购物车中是否有该商品，有商品就数量加一
            if (item._id == cartItem._id) {
                item.increaseAmount();
                found = true;
            }
        });
        
        // 没有找到商品，添加
        if(!found) {
            this.cartService.add(cartItem).subscribe(
                () => {
                    // 添加成功后？ push or get
                    this._content.push(cartItem);

                    this.getitems();
                }
            ) 
        }
    }

    getItems(): void {
      this.cartService.get().subscribe(
          data => {
            this.content = res;
          }
      );
    }

  toggleChecked(parame) {
    this.httpCommonService.postCommon("cart/toggle_checked_all", parame).subscribe(
      res => {
        console.log("toggle", res);
        this.getCartItems();
      }
    );
  }

  removeItem(parame) {
    this.httpCommonService.postCommon("cart/delete", { commodityIds: parame }).subscribe(
      res => {
        console.log("delete", res);
        this.alertService.alertSuccess("删除成功");
        this.getCartItems();
      }
    );
  }
}
```


#### cart.component.ts
``` ts
export class CartComponent implements OnInit {

  constructor(
    public cartService: CartService,
    private router: Router,
    private alertService: AlertService,
    private personalService: PersonalService,
    private cartsSubjectService: CartSubjectService,
    private cartSubjectService: CartSubjectService,
  ) {
    this.cartSubjectService.cartsInit(true);
  }

  ngOnInit() {
    this.cartSubjectService.carts.subscribe(
      (carts: any[]) => {
        this.commodityIds = carts.map(doc => doc.commodity._id);
        this.checkedIds = _.filter(carts, {'checked': true});
        this.carts = _.groupBy(carts, "commodity.owner.nickname");
        this.itemChecked();
      }
    );
  }
}
```









