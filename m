Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F27C433F5
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 01:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiDHBpH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Apr 2022 21:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiDHBpG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Apr 2022 21:45:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FA166E37
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 18:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4393FB82996
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 01:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0271EC385A0;
        Fri,  8 Apr 2022 01:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649382182;
        bh=HKAa0zZ+YfScnYiwonuO4THcQaAZWiT7gougIGWPYSU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OZIjTu/W8oyNhG7ciPLsXIUYQr/zfuV1qyJvoXYCBH3Iv2heRTzrYvwKHurqFC/Ic
         eiXcKvcIuW+bqpYF2Gj5Kd5uKV8Mr2Xi87W0EP6r99NzpgMLXepBi7R0zNR29MshIU
         Qi80nBKgY+DPm15BkU4VXJb6u1hzU7pArGFCOtyFLaG5NojJBDRAyNAA01crWhzeHz
         bDP99uvYWL0mKb5STI4F5A4kWNGrTo/1t6jHhC2UFGB8Kzy/8kkRgSlNEpMlDcthRm
         zgU1z9Y4jT5vfdD/QXMlLIBio9n0SbMMWK7KaaTgweIzhiyUdZLmomahQ2mzpBj26n
         CI0WVfmDKoUcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E7F65C04BE; Thu,  7 Apr 2022 18:43:01 -0700 (PDT)
Date:   Thu, 7 Apr 2022 18:43:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: rcu_sched self-detected stall on CPU
Message-ID: <20220408014301.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zhZaN0+KqP7oMoyXTSkDhLjZwWvnj7coa1ZVve9M+jsQ@mail.gmail.com>
 <20220406195011.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x8_783jhEhC3AozH9=xj40UO-rZT2BRJsg5gaLdBz=9w@mail.gmail.com>
 <CANiq72mYXnQo_Y39k23rY-rdJay8GEPJ8MhU-y7-bjkw=zRC+Q@mail.gmail.com>
 <20220407151555.GR4285@paulmck-ThinkPad-P17-Gen-1>
 <CANiq72k7BWjOU8=-dXD4bYWbK1i+rjDNaAohGrU42yJzcBm7uQ@mail.gmail.com>
 <20220407175500.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2yDe3dU0DtigvAE4CQLAipvT81Bw4LrF5WjLSiP5nq1UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2yDe3dU0DtigvAE4CQLAipvT81Bw4LrF5WjLSiP5nq1UA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 08, 2022 at 07:14:20AM +0800, Zhouyi Zhou wrote:
> Dear Paul and Miguel
> 
> On Fri, Apr 8, 2022 at 1:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Apr 07, 2022 at 07:05:58PM +0200, Miguel Ojeda wrote:
> > > On Thu, Apr 7, 2022 at 5:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > Ah.  So you would instead look for boot to have completed within 10
> > > > seconds?  Either way, reliable automation might well more important than
> > > > reduction in time.
> > >
> > > No (although I guess that could be an option), I was only pointing out
> > > that when no stall is produced, the run should be much quicker than 30
> > > seconds (at least it was in my setup), which would be the majority of the runs.
> >
> > Ah, thank you for the clarification!
> Thank both of you for the information. In my setup (PPC cloud VM), the
> majority of the runs complete at least for 50 seconds. From last
> evening to this morning (Beijing Time), following experiments have
> been done:
> 1) torture mainline: the test quickly finished by hitting "rcu_sched
> self-detected stall" after 12 runs
> 2) torture v5.17: the test last 10 hours plus 14 minutes, 702 runs
> have been done without trigger the bug
> 
> Conclusion:
> There must be a commit that causes the bug as Paul has pointed out.
> I am going to do the bisect, and estimate to locate the bug within a
> week (at most).
> This is a good learning experience, thanks for the guidance ;-)

Very good, and looking forward to seeing what you find.

							Thanx, Paul
