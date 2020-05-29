Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB00C433DF
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 04:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D3206E2
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 04:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g2oVffvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgE2Es3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 00:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Es1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 00:48:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15A5C08C5C6;
        Thu, 28 May 2020 21:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vIdlsNk1thlgd2wJmYEsdZAcqlZDKs65gLXHa0aj9qw=; b=g2oVffvDUd+ewmKpTwyGrqdBQW
        m9Q42HUdyfcH5SEhjTGLhoAVvr/CzUpv4kaUeIUFckaTwsNhxtbtE3eEhlVUPjjG+zT07IjLyIVpa
        GMrSiqJuYtST3QVfTxnkTM7QmVym28LIPfGMmo0/EJf2bmeWKck1el+9a/0aWVpNOMgxA4mzSao7y
        1MtjuUQ1cuCS+2QiNCu8HT8D0bq+sONjtS1do3wA/2nEFrt1y0gOPuxRf8SrhqXO0nGSb4JZUGHoR
        ZpNwcQ29YNw8qavBZgpRDCSFS4mqdV+eKb/fI9A2ISa9edrqsk2JXV5SVByg/CvzkxOA7GynRLNGV
        Gul9jxrg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeWwP-0000he-7z; Fri, 29 May 2020 04:48:21 +0000
Subject: Re: next-20200528 - build error in kernel/rcu/refperf.c
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <538911.1590725791@turing-police>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9d8b13db-9d77-416d-e283-9ea509ce43d1@infradead.org>
Date:   Thu, 28 May 2020 21:48:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <538911.1590725791@turing-police>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 5/28/20 9:16 PM, Valdis Klētnieks wrote:
> commit 9088b449814f788d24f35a5840b6b2c2a23cd32a
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon May 25 17:22:24 2020 -0700
> 
>     refperf: Provide module parameter to specify number of experiments
> 
> changes this line of code (line 389)
> 
> -               reader_tasks[exp].result_avg = 1000 * process_durations(exp) / ((exp + 1) * loops);
> +               result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
> 
> On a 32-bit ARM make allmodconfig with gcc 8.3, this results in:
> 
> ERROR: modpost: "__aeabi_uldivmod" [kernel/rcu/refperf.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:103: __modpost] Error 1
> 
> I admit not understanding why the original line of code worked and the new one doesn't.
> Maybe gcc is smarter/dumber about the ranges of 'exp' and 'nreaders' than we thought?
> 

Paul has already responded: (unfortunately)

"So I am restricting to 64BIT for the time being.  Yeah, I know, lazy of
me.  ;-)"

https://lore.kernel.org/lkml/20200528180855.GP2869@paulmck-ThinkPad-P72/

-- 
~Randy

