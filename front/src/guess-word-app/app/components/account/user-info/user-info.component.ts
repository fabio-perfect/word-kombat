import { Component, OnInit } from '@angular/core';

declare let $:any;

const basePath = 'guess-word-app/app/components/account/user-info/';

@Component({
  selector: 'user-info',
  templateUrl: basePath + 'user-info.html',
  styleUrls: [basePath + 'user-info.css']
})
export class UserInfoConponent implements OnInit {

  ngOnInit() {
    $('.collapsible').collapsible({
      accordion: true
    });
  }

}