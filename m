Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D77C433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 20:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A250207DD
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 20:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PnbzCTXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgFPUYq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:24:46 -0400
Received: from mail.efficios.com ([167.114.26.124]:45600 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFPUYp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 16:24:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C2E342BC34E;
        Tue, 16 Jun 2020 16:24:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id g_0CiEaMw_Mx; Tue, 16 Jun 2020 16:24:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 89AD12BC642;
        Tue, 16 Jun 2020 16:24:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 89AD12BC642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1592339084;
        bh=18w6fF8mOh+rBs9AqW0wGKeQUee1C4pGw/+J41u2jA0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PnbzCTXbyQxVMx6M8PLd4B54MnUMJRTyOPUtgOPM9SRzcStPX5Yrbfbtmj/Th5kOg
         JauYyCF/Lc92OkGpuFTC6x+Kkok1XXG4jmS0SzQXdmeFoVn7mZ9ivOdIjn7Dc/cJcR
         ls5WIgjZfWoilMfzjoK4KrxdfqbQyL7ZQsfwsryX/ur9J9RM8haIHUKEKoye7bd7gI
         1mhOQ52XGk+3CuRp7wBQy0ff0LWjbuFpHezDHPPXB0JuAHdswctRu+6rIHp6T5z7ur
         FT09T1hkHEDMaiiEpZtFKLJqxuJY6wd5YRAO1QOJRxopxqdJZkCLwz3EPeC67ZX+f7
         faTnV0lqvQluA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U7VcYXgjh0JG; Tue, 16 Jun 2020 16:24:44 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 799C22BC72C;
        Tue, 16 Jun 2020 16:24:44 -0400 (EDT)
Date:   Tue, 16 Jun 2020 16:24:44 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <1909772924.4639.1592339084357.JavaMail.zimbra@efficios.com>
In-Reply-To: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Subject: Re: Question about list_sort() RCU version.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: Question about list_sort() RCU version.
Thread-Index: AQHWRBs42t9q8JLtOk6vT+rVgdWIUtSFnJSl
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Jun 16, 2020, at 4:17 PM, Chaitanya Kulkarni Chaitanya.Kulkarni@wdc.com wrote:

> Hi RCU maintainers and experts,
> 
> I'm working on a linux kernel upstream project which is in the tree.
> With the POC I can already see that significant performance improvement
> with RCU in the fast path which are replacing rw semaphore, but not
> having list_sort() rcu variant is blocking the developement and getting
> code upstream.

Why do you need list_sort() ? Is there any way you could simply insert your
new elements into the list in already-sorted order ? This would ensure that
the list is always in a sorted state, which I suspect will be expected by
RCU readers.

Thanks,

Mathieu


> 
> I was not able to find the such helper implemented for the RCU flavor of
> list.
> 
> Can someone provide information about :-
> 
> 1. Is there any plan to have list_sort_rcu() ? if so when can we expect
>    that ? (Also how can I help ?)
> 
> 2. In case there is no plan what are design considerations if someone
>    wants to implement the code and submit it upstream ?
>    (Also how can I help here ?
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
