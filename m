Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F14C433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 23:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA1207E8
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 23:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z8qCXeQn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B/nVGBT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgFPXV7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:21:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20323 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgFPXV7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 19:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592349718; x=1623885718;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GCYNpHGzEctYNW5s4SvzRaLTEJNZbjlsYWVgbk5JT/s=;
  b=Z8qCXeQn3pfJoV4jIrIxYTi/6ATt3Us3P8othbEMqVkGdnyrrSlmXvTo
   kHy+gv4pjG1twQ/+iloYeleaRQtFE85Ny2tMHY5NzI6qI4N+7c+KvcC1G
   s7EE/BIf5NzOB2smFTBBA4NFkatBUb9xPtTvJsp/SP2mJmGRgnrCymXyb
   9K8bn7M6TjQh8wAFrbuDkYBtKgs8/FqbZdMjhqJzXTezjFLOFxEQZ3m9Y
   K/V5zohHGtZPm5Of6EX0LnCexFMBPxuqFeKFuKXnXDc7axEk8+PWKAHAA
   o9oWViFTKg6vKoJa9i79WZeCIiDcILM3i84gYaojpuc3QjrrRM5jyD0Oq
   A==;
IronPort-SDR: 3MJKxWd5ZMEo9RmK1O8O41id7T5TDjqEU85k+LNhS8RFHluy7Cn4oL40155OI8mE3N4aqfnIxd
 q9ZvXcqxF90K48mYS2b0/Zemv9wvkBSgsZ8/2XRutWSL8jLMkjUEmC6bvfriXWJYr43fmvTFhz
 TAa8NK202d38Ou5Jsc2AjeHfi28AGu6aG6YCXk5N0z43gn25dhnfA1bxpbhZZQ29EmMqQ+JlAJ
 3SrK2UFq+0PJDOmHiOHJYGW+tNonDu3+0K4/tyFvltL469dPx8M2306hoREnE1a9PGWQx3MgLm
 wtM=
X-IronPort-AV: E=Sophos;i="5.73,520,1583164800"; 
   d="scan'208";a="144490793"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 07:21:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe6H7+tB/iPiYWtBoPq5uEI4JQvxdFa8VS5u4zUcY6mzZsame/syo2cbhy0erh7qAoKAScPumOWLWb0TJc41rWFHWWR85/Mw9iVyPyurVobw0NZ5fHwVAwBho5KLC1W2Ji73W+NTnCAVJYlPwrrD7VILHYYU+CfNGr2ip9F0pE0E+CRXTOZHAd5l6w/JO1Wfo6ZNCBN7Z0jM6rrL60OZ7du7NP5jmF0LmX1xZVGu3+1V13IpcB6F8LpE9HYVUKrOSVhsQIRjO0/15EM2T/6MBxUG5r0TnQtM/YqtOXjANACNfgr7H+nSYTvptdvxaHzRx5EC4gkhc2bNWr/JvUySeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//6aCD/z+MLvEY48zMJrZgzeZ197lfFVRc3kmHHPIIs=;
 b=Cdsqb3paB/uL26qgpH7Wt2Z4Hx/nbAyTfoCUTY2sZ7XI6A69kB+Wb3kcYD0jC+m/aoYaBChZPY00zbFD7TiYC4LE8+NsQ7Pif5Ds9zy9/YiXLLTRai1JB8gsJC8EqLhR0K2b1RBPTit3/yOJ+PNnX/7v+VOb1KjyMVZCJRLChPIn7JzprLz/N6GdulCdTg6BPlq/JSNl6d9SvIKRqU1FZEeWQvj8cGzMjvSdUOZZxrqgsU0pILBg+WtOBwB8T16+JVoxUWuRrzPhf4Qy6fsRu/+K4P7PT9Orm9uqS2PKqHLIBw+KprRGtRya2UC6EVX6MwSXyE5qyB0aJwZP+6w2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//6aCD/z+MLvEY48zMJrZgzeZ197lfFVRc3kmHHPIIs=;
 b=B/nVGBT2lmhIMteeYOxjRmC1CT2XCgdIuLb1xhfxteulxtxgk3KqHj1EcXz+9t1U3vM0pGkD/B3PR8F1MzKl5lhk46I/tFi2n6fsci3e92+y6dKLxknT2hwuiPrVap5sW3mNSdryMaGwd2PZSfyRnx4Ld0/WuNZ+KGrpBatHyKM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7123.namprd04.prod.outlook.com (2603:10b6:a03:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 23:21:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 23:21:56 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Josh Triplett <josh@joshtriplett.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
Subject: Re: Question about list_sort() RCU version.
Thread-Topic: Question about list_sort() RCU version.
Thread-Index: AQHWRBs42t9q8JLtOk6vT+rVgdWIUg==
Date:   Tue, 16 Jun 2020 23:21:56 +0000
Message-ID: <BYAPR04MB49657ED94E122D33B9C53403869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200616174756.53309ed0@oasis.local.home>
 <20200616222933.GH2723@paulmck-ThinkPad-P72>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fb0581a-dcb3-4da5-8eff-08d8124c0fcf
x-ms-traffictypediagnostic: BY5PR04MB7123:
x-microsoft-antispam-prvs: <BY5PR04MB71237807A99AEEFFBD280567869D0@BY5PR04MB7123.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4XHZLYSslnIa7i5OGXC4B18QlNLSCmjXPkLpkDDij64dU85q190dcGRRByAhuFF9DeiGVc7+e8NU7KhsbzHtWG/hqGyDsOvjfPOnJfZBMm3WUOVgMlmHWPzneIi7wYAFBnGRy9z8d81hTVblBWXOC0/dBPQktrUeNhjQkob/qa5EA3Fxo2nFRFjSNUeh0dtZSeIc/l0pMYOurFBZkV4WW0Tonaw+MTqmnld5kwko8Gn6NG/PFz2fGMeHAu+xYxAQC/P5q8zXKHD7n8oEzb8WmgXjovpEE6I2uLHuJe45CkZYTYIc2Xyftx7xXCsS2TCzD3A7SrMqSLlOgYMFglyjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(2906002)(55016002)(9686003)(478600001)(54906003)(6506007)(53546011)(110136005)(8676002)(83380400001)(71200400001)(7696005)(186003)(26005)(316002)(8936002)(4326008)(33656002)(66556008)(64756008)(86362001)(66476007)(66946007)(76116006)(66446008)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rPjgq0rmzU3zR/5x3X/gtGAI/zUkUqaF94Cga9FDC+lrBmH4D4BML8esQPtQBogL5dGvxqwBG603G4LxAN65BsftIHNV9XtWESvI+zlNCJP7q2NZZ3dAxI56tU3zcja/WJLLSfCVKTo9YNzX4e6KxsUOeurrUUfr987r9NYclLNud2Ji7Zy2LXWbD0zQfbjw8kjA0lbFt1YTmUT03nu8kUm5A2DToDySm8ImDaeYwgaUg/dKP+Tj6w9n6KYuJZAio49t6rA23B7/0gxJeJo6FoHNOvwTWfJHou9A/YLcLf+kydSPIc9n0VfjP+Bf6iunK4FeQtmDKVfuXNVtSM9o15JIjAsStBwQsWtunhgs1OLol6n5AMRrV4qEytwVenUfsJCXEJC+eQcQL3E0PL/+C18ZftukugtPTsRg+f5Uu2ojm8NYWUzsD6lHtXcNgvshwVa9rCnCpRY0S0Ztdv7Vv7Zu8ZlHDW4Y1I4vVNuwWOY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb0581a-dcb3-4da5-8eff-08d8124c0fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 23:21:56.3841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWu5T9jZcDQDFZFj8WERAM0zLFqbIu+haF5JBSWFclPnqdeCnDQ7aAWjUlzBcrfE1E6g5w0OfR+2YRfIlajYPp4A+Wx1oafcmb67CNJ8+0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7123
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 6/16/20 3:29 PM, Paul E. McKenney wrote:=0A=
> If you want things sorted, why not a search tree?  Or, depending on the=
=0A=
> purpose of the sorting, a hash table?=0A=
That was my first question but the way code is written right not which =0A=
uses linked list and then it calls list_sort() which is not a ideal data =
=0A=
structure to start with.=0A=
> =0A=
> It actually is kind-of sort-of possible to do an in-place sort of a=0A=
> linked list in the presence of readers, but the simpler ways of doing=0A=
> this are not at all pretty.  Or efficient while the sort is in progress.=
=0A=
> =0A=
That is what I felt after reading a code and I'm not an expert in this =0A=
area.=0A=
> o	Find the largest element in the yet-to-be-sorted portion of=0A=
> 	the list.  Pull that largest element to the front of the list=0A=
> 	as follows:=0A=
> =0A=
> 	o	Set its ->next pointer to reference the first=0A=
> 		element of the list.  (Yes, the list is now=0A=
> 		looped, and readers looking for later elements=0A=
> 		will follow that loop.  Readers must do loop=0A=
> 		detection, and restart their traversal after=0A=
> 		momentarily exiting their read-side critical=0A=
> 		sections.)=0A=
> =0A=
> 	o	Set the header pointer to reference the element=0A=
> 		being moved.  The list is still looped.=0A=
> =0A=
> 	o	Wait for a grace period.  This is why looping=0A=
> 		readers must momentarily exit their read-side=0A=
> 		critical sections.=0A=
> =0A=
> 	o	Make the moved item's predecessor point to the=0A=
> 		moved item's successor.=0A=
> =0A=
> o	Repeat until the list is sorted.=0A=
> =0A=
> Another approach is similar to Steven's suggestion, but uses a=0A=
> separate set of pointers to do the sorting, then switches the=0A=
> readers to the sorted set.  This allows better sorting algorithms=0A=
> to be used.=0A=
> =0A=
This is the most easy approach with high memory usage.=0A=
=0A=
> But why not just insert each element into its proper place in the list=0A=
> to start with?  If the list is too long for this to be efficient, you=0A=
> most likely should be using some other data structure.=0A=
> =0A=
Agree, again not my design, and after these emails I do have questions =0A=
on the data structure since with an efficient data structure set of the=0A=
items are also be cached that will furthermore improve the performance =0A=
given that size of the ids is cacheline friendly.=0A=
=0A=
> 						Thanx, Paul=0A=
=0A=
Thanks again everyone for replying promptly and in detailed manner.=0A=
