Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB61C5519F
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42ED722252
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 08:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="iB5pYAAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKTIa0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 03:30:26 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:11616
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727139AbgKTIa0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 03:30:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe4gCBkgvbOcW5h6nt0UNjZ4cL88oQlpxfKro4GsCG4AFHkorrfqeKu3WnofxjUMuN75vDV1ncduwku2MORs9WFFzsylQldRmt1+cTZYcWcbOkErsT2ehgEUckCH7aQTx0TT5tjN5V0K6g7FFvePtXMTdadTyyWnIQ+pkaibX2Gsu/cNWOdKca0rS62HS3KK7n14zal2KTq6+6rjXVqk/AwrlXPF11+L+TUJl2l8szRVQv/FlLk8H1O5bMkZjeCo92j9zH9DCYygSjhzOlfU/a1cauiyWHSQrAaSuFm0X5aJ1XWGHmLWAN9HSd5E+hoeqxYBh5IDnvaHc4e6QCFOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgehhYNGvN32tW8XUyOQbFJZE59DHhFm+UbTf7eoC0c=;
 b=RLEJp0WC4perVx8X+oNeTNJxwI+GeL2ipMeTIgszoBKaocPkM/Xjlb28x2e17QCJNBBH4O0nDXOcvyXr7o+/foa9DY7LGs+lzi2UL4Z2GssGAnlpYHXiaHs61UnpWE/Dm82JUL8et2QJ3H+PM+MWV4YGi2pnkBPkSGv4Zt0sm+Bt+E4RgUFcJYr9AvO8//DGWLWI+FiFO3WFhEd2FxJGaZut60fYHdoM3XEqJIqAqsN/hFaPq1EGbHbuiFl1/Ol+VREGj7jxW7ptdqSrNN1+5Q6Y8Kj8pbO3ozl5NBoJjN3srIANQhRimd0ExMKR/AJAODGGmva7zZMD6dqv6wwrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgehhYNGvN32tW8XUyOQbFJZE59DHhFm+UbTf7eoC0c=;
 b=iB5pYAAZ195kIbqnBOigTIUu3kjBMD5/iGd+vb4FDk+HF1YmRgU6sKm2EtCdcYBordZ3gqKKLBdGIW0P8hR8ri/sV2197Js+d+DxDdktEyTxMcCSAZ6QPZxaehJf3fgnrUqT0lvCBP4zzyGB5LXr7O4flVn2cGSnuC9UP2pUlZ8=
Authentication-Results: joelfernandes.org; dkim=none (message not signed)
 header.d=none;joelfernandes.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 08:30:23 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7%6]) with mapi id 15.20.3564.031; Fri, 20 Nov 2020
 08:30:23 +0000
From:   "Zhang,Qiang" <qiang.zhang@windriver.com>
Subject: SRCU: Question on srcu_advance_state
To:     paulmck@kernel.org
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Message-ID: <7fc7b6b9-bcf2-fa78-1931-415d04a5ac1a@windriver.com>
Date:   Fri, 20 Nov 2020 16:30:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.183] (60.247.85.82) by HK2PR02CA0128.apcprd02.prod.outlook.com (2603:1096:202:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 08:30:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d6541b1-362c-499d-01f7-08d88d2e85d2
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4976:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB49763132F3711F1976602050FFFF0@SJ0PR11MB4976.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qi/elZ+qxxT5VF45Bq+X3ruf1zqYG6RTay7fywGrJkScOB0d0Fh7PF1LO5799eS/RfELRyZ98NFEouf3MbpemWwwJvh3QGavUVwAJMs/6ujHfYlhsO5XeZhUq0eEBzZohXTuHxnaMN//KZ2RC0g3zUjNSiZuEabK/K1l3EbUQoHfjyhNBxXgi5bHpL6hM6qVxrVYSflSQ8IavakF3Ha54+KJsRwVYdyfXUvjWrqQ1LT96rZxN+HLaaYLLFxGyR1rCENBb7lSQ8wLlu0Qk63qIJ6sPpc6aHHOpLdixKkjv14XGck7SR8FIp3WIBso7E6jEB7Bcjdf6d9VLf5Yw5e6YgwLvXDFJ3TJeUE0Umd+Lw9JAqqaQ5B5dy/cnhUODDi5mR6kNUOAsihbfAkEX2T5+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(136003)(346002)(376002)(86362001)(956004)(316002)(6486002)(26005)(16526019)(186003)(36756003)(66556008)(5660300002)(66476007)(2616005)(6706004)(6916009)(478600001)(66946007)(558084003)(4326008)(8676002)(16576012)(31696002)(54906003)(31686004)(2906002)(6666004)(52116002)(8936002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LxOShGRGxQktWPmr+aTqCN+pTzzGNHVpEzCDPsqBoIxAJxjVjdN5NS44w277Ri4D+sXNNQ4A19+693YDXvF/qP4Mw3BbCQm8vE1PjchNUrSn5lwSI9lt1FMibLCpHGiyn9ACB7HorVKIzhdn6n5FAw4djSM9MVZLWX6Vjvsb2AaXtMqQJdAfG82XhhygaTL8tayf9GXW6EiY8Ic2eaLlYLmmL14BHyt7wPiuJ5YH0z3fhIzlouiPM+Ws9kQdFaCua4ZM17HKajx9bBcQp0QNiJ7eRiWVByqJ1dT1E0Z31Oc+K0xE31NO2fWlidNl2ZcOpi5XPaXzTkn415mgUnyBZIrPXriDn2RZFvkdN25np+JSzuy2Q/Vq8JUai8ya5zXCgmXJLCJ+dCpWPZ8Xm1lj1mU9Ugh4OOTpvSzM8crF1QGBxNMF+ezpO5Z/CwzFIW4GZISWSPNw1T5gQH4d98l7WOgmK5QZ0foGSW/ADfdsI16rAAWTWwjG+luRaYgGWmjQcvSd/nrhJi7kdKFSJB7NJp9dOmFuR+stNmgetejjU9jlM2h+xdMyoqoejwSgvyahO1DgwJFMupdcQ0lVzixO2bWa640Rnw8Sw2vunpoNYS7y8rW87OAXgR+dy12hodf+7EA/Pjt9j0SahkJaVcNVWg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6541b1-362c-499d-01f7-08d88d2e85d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 08:30:22.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gur5NyDFi0gH/ce1Ew1GwESD0KQNEEGt8jKK7iKiK6Dab777OAn+ebPoI5a5LQfhc6xzHbqWyhe5AtG/VsC+ggU8j2JZWtdog318qxXjVC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Pual

sorry to disturb you, I also have some quesetion for you:

in srcu_advance_state function, when seq state == SRCU_STATE_SCAN1, we 
will check, if the previous readers critical region exits, will be 
returned directly.

I'd like to know under what scenario this will happen?

Thanks
Qiang
