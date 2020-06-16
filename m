Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2CEC433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 22:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214E620786
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 22:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cunJYlJB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QD1WAaCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFPW0T (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:26:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57384 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgFPW0S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 18:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592346377; x=1623882377;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5fhQLT+75JYR57AywK+XLAfNU0qcLboOj2Y9O/j41KQ=;
  b=cunJYlJBTmUwdh6HamFXDrQ9bwY0V3q28wWVidqiesgcLtb0GVFV3Amk
   H1iuEGRLNHGnsqc0RM4Y+6W7At8P5u6Cj+4m7bepjs7mljIQDUbCx0syO
   8lyQsHrtSDHGkHZ13o5pDHoz5WxxHP1YE4mTZbIZp7zuLbsmhjMKkdDKO
   FZdEKMFBoXbFzkemmRe15KKAwrTXVeY92uqewvZJuT2a7sOwAWxJ/TC/v
   PPIvwQOtO2lOdPkizAFSG6m1ngTMsHACz0mE12SUMJE6tAhYJ+oqe9xKb
   sZZJ5rrDdiIJ74T/s21/gzXEqq9/WSPR2TIL6CWxOaD7a5LlcVeBQR1z0
   A==;
IronPort-SDR: MmOH8J25aeJlw1OCfnUAOk9sKP+SwHroArq/O56xwwFo/NXXcT2Z1WICSBPENE1oNvnnocciWU
 v5H3XrV2GIBnUF/gIpNjGpnDC18g5lKG2lS1u8arOu7obeIlk7YSuSgERgE4S2CCZvxWi62J/N
 siY/SWVqtPHQQR4kg0PxXdqtc1dtDQ5NzZMtXIYPeCkQABCPMjPVoLF9emL6B/RPpNpjh4Rzgg
 zfR4rZ9pNlm40fE6h8ceJHrs2TXN1sBWN1u1dL8fJJigmVD5IpnJB5ajnqgJcm00bJusDXmKh2
 IOk=
X-IronPort-AV: E=Sophos;i="5.73,520,1583164800"; 
   d="scan'208";a="140167167"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 06:26:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND893U15sg6GaeKkGEvxwWDT7gNp+J2Z+Zcw9mU4BPw+ycxKMpatG75a2UEzH3Vow5C4VzL52K2Eax02yf4s8QlvSnNT2ec4nyOOIAwrS76pjNZWG5WH7B1zoFHgIgzcvAcT610sbOPdR74NAGUB7Q4Y2lKcAsQTm8aHWMwH0s5n9F8SnOzml/pjHkUEEvDBaGdnlIVGyo9ED2jA1+4A2EfUoQ8CDADqE40vAzH7wVyVg7wEVzvhtI9rpJdyTYeMrhSru+WJqHWeqV+vyd6LerxDJ4jAw+BG7CmcwPP/sEiPViNzKVLgjyAoS+TD75P+ysgE06gRGHR4tEz5jUk40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKoFJgVlK4F1oPy1ONKz9r9PBhLqhg4AnW4Yj7dAasQ=;
 b=ZmEQUD6sbXs27LXNUJZoeXr7EXju89ZFn7D2hG2lAeECDBr2fbxMNSLyx2AEHpRZITfFUv7Cox7JWdB0nlHm5OltOEo+KkOVSXpOi4u5DkmTDDbyoyjb09v8+fNHfEuzoKUbY9saZrreKg1PLCdBJrEv+Mz3f/d7KH/qs1/JEGgzgY+5W2wHvqHBtEV3DcKDLkuJ0gA0nb//I44Fdi+OWaEVPhgJ9yjujAKbC54NWxeA681OuqNAnu71FRUm4jL6uUeGIa5Z1PmL3njX+Ddez3oDXGAqMi4By6Zy7vcWfUOJcWXB/RcR+adfja5ppnC0JambqnxQzPeWgU8FRbLzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKoFJgVlK4F1oPy1ONKz9r9PBhLqhg4AnW4Yj7dAasQ=;
 b=QD1WAaCi+fJiReCUO8ay7dD3cybSE53N+YDXwjn9ls8pl9txduIfk2gbtOURp9D0ZoDw7nJkLziocsL7VKjBluobwlB72+zIMnray+uckzYtbhaqlDcHDKilg6qbSbM5aMM2q12jWncoBjLEkrysKH2Rqe/Sf4bp2So4DaTtRnA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4872.namprd04.prod.outlook.com (2603:10b6:a03:42::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 16 Jun
 2020 22:26:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 22:26:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
Subject: Re: Question about list_sort() RCU version.
Thread-Topic: Question about list_sort() RCU version.
Thread-Index: AQHWRBs42t9q8JLtOk6vT+rVgdWIUg==
Date:   Tue, 16 Jun 2020 22:26:14 +0000
Message-ID: <BYAPR04MB4965A882732B601EE63AA8DA869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200616174756.53309ed0@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c51ab5f-bdb0-4077-cfa0-08d8124447d2
x-ms-traffictypediagnostic: BYAPR04MB4872:
x-microsoft-antispam-prvs: <BYAPR04MB48723A47E8FA7AFB82A21AFA869D0@BYAPR04MB4872.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PlzeRis6XsCqdD7smLhR3suKkia2qfbCHKzgvy57Q56IdrbJqgU1hJdsmIhN5AbVqaX1UiAtNcWmIRpUsLe+DJ5JNNYS+qavCw35Kp3uRkIlnW5ZK6ypPmVPyW2dVtWEm+crp9Q7Zq+sGoPxsFEPvcud30z5IIhOOkWsjZRG2vddx7MLkguMvdXjqRyUt+2qSnYRL1BOx6fN9lSYCL13+MlYnJkjhITpJy2mzarQ9B74F6HDLlmA0+oinQjfw6ksTmIcXGEE4Y77xcarLXxrGtOpzkGk4tMSdFfpj/omhCA3uYz6YZeqe6O0lKYk+vBrjdROkXWnZzG/+M/6A5oO9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(6506007)(478600001)(53546011)(186003)(26005)(8936002)(8676002)(4326008)(55016002)(86362001)(9686003)(33656002)(54906003)(316002)(7696005)(6916009)(2906002)(66556008)(64756008)(52536014)(5660300002)(66476007)(76116006)(71200400001)(83380400001)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LJGnVtXss3bvzvub4DZZSi9VW+7jDybL9oq2K0M2b/KMetpjKNVX/UI+CKRiPD2XEtbCx4zkZRk17RHw694bqd2WMLf+ERfPcTRw+Itupo/YYyw8XXg7HwJddsl56nrn/qzaBk+FhOMu+E+ZdxnIhR8v3wF6jEJSgBidryNI1GFwskWGSlmioFCvDrFEWyFJH7yHqcIcHmuNPGmpJcO3GqGiSHeIQxoDmbkjPspviiE0iR2PQlkJcwqTYRn3p17e26WDxdifpHxSYGhHhj4BiSfk++aoK5mEtAyMfkDnzSswMYZb+LgqosqjgSEGSVFgdfFNGoyH1Tj/DEVQGWxbH8gCDeMvnJ/icGjtMCdI/TQisuPjHcP1N9tn4WRTpKSA8lSkoC2ZErbsOMAX0BRucC5p5LLl1ZJQPgoIRYWw/F/IXPfQ91U1nHzJf+Xugvd+BiVufPQZdLQAVCC8gaYdFXDD/ZFzlVuTca1xsPGa/sgSK+Fct96jjMImDKqyl7sv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c51ab5f-bdb0-4077-cfa0-08d8124447d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 22:26:14.3080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+TQt+pBYLkcUY0dm4E/L8vg1KZfnxG/grvn3MHd7lUdg49WKMHI35C/2AhcbKelN9XLAtvzHivY9U7c5rFe5Yp4iKh7QbWBxy5gjo1Q59w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4872
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 6/16/20 2:48 PM, Steven Rostedt wrote:=0A=
> On Tue, 16 Jun 2020 20:17:56 +0000=0A=
> Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:=0A=
> =0A=
>> Hi RCU maintainers and experts,=0A=
>>=0A=
>> I'm working on a linux kernel upstream project which is in the tree.=0A=
>> With the POC I can already see that significant performance improvement=
=0A=
>> with RCU in the fast path which are replacing rw semaphore, but not=0A=
>> having list_sort() rcu variant is blocking the developement and getting=
=0A=
>> code upstream.=0A=
>>=0A=
>> I was not able to find the such helper implemented for the RCU flavor of=
=0A=
>> list.=0A=
>>=0A=
>> Can someone provide information about :-=0A=
>>=0A=
>> 1. Is there any plan to have list_sort_rcu() ? if so when can we expect=
=0A=
>>      that ? (Also how can I help ?)=0A=
> =0A=
> I'm pretty sure there isn't any plan.=0A=
> =0A=
>>=0A=
>> 2. In case there is no plan what are design considerations if someone=0A=
>>      wants to implement the code and submit it upstream ?=0A=
>>      (Also how can I help here ?=0A=
>>=0A=
> =0A=
> Good luck! For RCU to work, you basically need two states where both=0A=
> are "valid" for a time. You have an initial state, and then you have=0A=
> the state you want to get to. In the transition period, readers will=0A=
> see one of either those states, until the last reader is finished with=0A=
> the initial state, all new readers will only see the second state after=
=0A=
> a quiescent point in time.=0A=
> =0A=
> To sort a list, you will need to modify it in such a case that the list=
=0A=
> is valid for all readers. This requires moving a list item. The problem=
=0A=
> is, this will require two modifications, where the list will not be=0A=
> valid in between. How would you move an item where the list is valid=0A=
> for ever change? Say you want to move the last element up. To do so,=0A=
> you need to remove the pointer to that element, make another element=0A=
> point to it, and in the mean time you need to update that last=0A=
> element's pointer as well. You can't do all that at once, and doing any=
=0A=
> of those without the other two will make the list invalid.=0A=
> =0A=
> One answer is to make a copy of the entire list, sort it, and then make=
=0A=
> it the new list. That's the only way I can see this work.=0A=
> =0A=
> -- Steve=0A=
> =0A=
=0A=
Thanks a lot for the reply and detailed explanation, it doesn't make=0A=
sense to go thorough all the development effort and make it generic for=0A=
one use case.=0A=
