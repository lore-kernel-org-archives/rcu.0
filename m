Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C092C433F5
	for <rcu@archiver.kernel.org>; Tue, 22 Mar 2022 10:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiCVKuo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiCVKun (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Mar 2022 06:50:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11DA814BC
        for <rcu@vger.kernel.org>; Tue, 22 Mar 2022 03:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 649E7B81C94
        for <rcu@vger.kernel.org>; Tue, 22 Mar 2022 10:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5EEC340EC;
        Tue, 22 Mar 2022 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647946153;
        bh=Z1L/Hr4DtTFYB17HEzf0n9pRecFYGAznxsxCxUy+qpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOB2g26MfT5hTF1cdNqskhS+M0XggbUGUertORSbClxgSX476zmqPkpfxUEOUtzGG
         e+z2gEyj2ElOmkBRlHVuYbsyXozCaOAFCmKXSnYqIdCFG2EO8UOmA+xrowkY7tqr8L
         yqebjbJwumYIxjHyycDofzYMhVP6v4QpANOjjbT4HnzoHE9Ja7uS2C4iHFVxF/ufCD
         J0WkjYN5hJ1Zt799CAT5YZWaVqJyjZnOilUiJxFnW1D8w0zzu3P16QqgxBT+Cz0FJA
         UZNOOoTN/TaCD/wEMHPzd1PA4FevVEGwDFJhAC+UFYCo1TR2NTBmDGpo3lsJ6dFTaf
         pvCdtv562QWlA==
Date:   Tue, 22 Mar 2022 11:49:09 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Paul McKenney <paulmckrcu@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Fw: rc6 splat
Message-ID: <20220322104909.GB701946@lothringen>
References: <Yje18NgLjpPo7VEp@casper.infradead.org>
 <SA1PR15MB49655CF8AC3998CA9A7CE903B8169@SA1PR15MB4965.namprd15.prod.outlook.com>
 <20220321043813.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <20220321071327.GA798064@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2woW2UuPg1rSYYc+S6k7qd9JwM4gJFMHhiVcBkDewE_Nw@mail.gmail.com>
 <20220321155746.GG4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321155746.GG4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 21, 2022 at 08:57:46AM -0700, Paul E. McKenney wrote:
> On Mon, Mar 21, 2022 at 11:46:28PM +0800, Zhouyi Zhou wrote:
> > Hi Paul and Willy
> > 
> > I can reproduce the bug. Following is what I do:
> > 1.1 git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
> > 1.2 cd linux
> > 1.3 cp http://154.223.142.244/20220321/config-20220321 to .config
> > 1.4 make vmlinux -j 16
> > 1.5 kvm -smp 4 -net none     -serial file:/tmp/console.log -m 512
> > -kernel vmlinux -append "console=ttyS0"
> > 1.6 the /tmp/console.log is uploaded to
> > http://154.223.142.244/20220321/console.log
> > 
> > 2.1 wget https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.17-rc6.tar.gz
> > 2.2 - 2.6 the result is similar.
> > 
> > I am very interested in this topic.
> > Could you please give me about a week to make a full understand of the
> > meaning of the warning, and try the fixes one by one, and
> > find out what happens?
> 
> Works for me!  The eventual fix likely involves some version of Valentin
> Schneider's patchset that provides APIs that allow RCU to detect the
> current preemption state.  Which can change at runtime.  A prototype of
> this patch is on -rcu here:
> 
> 2436ee0b4cea ("EXP preempt/dynamic: Introduce preempt mode accessors")
> 
> It is entirely possible that the fix might need to go to mainline sooner
> rather than later.

I guess it's possible to do that but that patch alone shouldn't fix anything.
Also, what is the issue exactly? :-)
I can't rewind far enough the conversation.

Thanks.
