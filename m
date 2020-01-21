Return-Path: <SRS0=d+Zk=3K=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1242BC2D0CE
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 16:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF2E217F4
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579623334;
	bh=6+5P66QAKeRI7mGrXlVSlR40nnRCq51D6N+RaOGEldA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=skNJyPm6FzKQJ/IAMjxDQZc4J+CAUhA4y6ZyKvTb+jEqgED/LkU1h3ZK6q9eRPfrm
	 iby0LxAiROUblvnGjbLj/8muuy2HHmad54K/y98WvOtQ357+pEbiJYcZ4RaWghOY5f
	 ZXCOfSMnEXGVKfbhuJJ8kCLOdNCqnGl8fjKNpvWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAUQPe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:15:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgAUQPe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Jan 2020 11:15:34 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E273C217F4;
        Tue, 21 Jan 2020 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579623333;
        bh=6+5P66QAKeRI7mGrXlVSlR40nnRCq51D6N+RaOGEldA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=12gkYzppKDFrRwmcHyzvE01vP5VdHB4WBF2QIaIiChiwkzwR2uGG50Oh9Buqz2rP0
         VoJkWoURBd8dFLJDJpxWmkFuwZ+G8vO4ZJp9Dsctb/ccpJECtbpQ0q4PfIOYQ7u0MB
         guXLGn9jM95GC6hkQuDOsMAAvgnKTNANdAxWJKbk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BA23C3520DC0; Tue, 21 Jan 2020 08:15:33 -0800 (PST)
Date:   Tue, 21 Jan 2020 08:15:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Boot warning at rcu_check_gp_start_stall()
Message-ID: <20200121161533.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200121141923.GP2935@paulmck-ThinkPad-P72>
 <A230E332-07D0-40A8-A034-33ADB4BFB767@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A230E332-07D0-40A8-A034-33ADB4BFB767@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 21, 2020 at 09:37:13AM -0500, Qian Cai wrote:
> 
> 
> > On Jan 21, 2020, at 9:19 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > One approach would be to boot with rcupdate.rcu_cpu_stall_timeout=300,
> > which would allow more time.
> 
> It works for me if once that warning triggered,  give a bit information about adjusting the parameter when debugging options are on to suppress the warning due to expected long boot.

Indeed.  300 seconds as shown above is currently the maximum, but
please let me know if it needs to be increased.  This module parameter
is writable after boot via sysfs, so maybe that could be part of the
workaround.

> > Longer term, I could suppress this warning during boot when
> > CONFIG_EFI_PGT_DUMP=y, but that sounds quite specific.  Alternatively,
> > I could provide a Kconfig option that suppressed this during boot
> > that was selected by whatever long-running boot-time Kconfig option
> > needed it.  Yet another approach would be for long-running operations
> > like efi_dump_pagetable() to suppress stalls on entry and re-enable them
> > upon exit.
> > 
> > Thoughts?
> 
> None of the options sounds particularly better for me because there could come up with other options may trigger this, memtest comes in mind, for example. Then, it is a bit of pain to maintain of unknown.

I was afraid of that.  ;-)

Could you please send me the full dmesg up to that point?  No promises,
but it might well be that I can make some broad-spectrum adjustment
within RCU.  Only one way to find out...

							Thanx, Paul
