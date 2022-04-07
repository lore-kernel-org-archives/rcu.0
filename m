Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3E0C433EF
	for <rcu@archiver.kernel.org>; Thu,  7 Apr 2022 17:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiDGR5E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Apr 2022 13:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbiDGR5E (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Apr 2022 13:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F618CA6EF
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 10:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED25061BDD
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 17:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C03C385A4;
        Thu,  7 Apr 2022 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649354101;
        bh=NjqPIHsoPThEmFMj3pqLnI9A1ClWJ6kDy569ZQ6WmFI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Eg6eeKS57vUMS8c9cB1S0SCjMUvA8KuurAmnbiRc84hnqg8KA2iLIuA+bCcEJaVRI
         rukTsvuq8FbOg4244AzGK/xzr1o2tZ7pQGW2750YB/sGx/9udWx9FsAISIgGVn+X+m
         Ka31B6Kfrxr7iggzTVjnP94a2gcCOOoa+iu6Ni3ChRpQMKKv3r4/JBQROIGBsC/SSK
         Tb846uJxPF21w/TNaOR2MZa07u56X6Y4dPIgrQS2zQu+IGFVhM/PGq6xl2j+W7XEGe
         Zc4p7spe8DxFaiVkhWEE5Ewy7nfB1PK02XyiCxAlUWHceV5AT13bxlIauHlikz4+qt
         FbndlCopC4Jgw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF5955C3267; Thu,  7 Apr 2022 10:55:00 -0700 (PDT)
Date:   Thu, 7 Apr 2022 10:55:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: rcu_sched self-detected stall on CPU
Message-ID: <20220407175500.GV4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zhZaN0+KqP7oMoyXTSkDhLjZwWvnj7coa1ZVve9M+jsQ@mail.gmail.com>
 <20220406195011.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2x8_783jhEhC3AozH9=xj40UO-rZT2BRJsg5gaLdBz=9w@mail.gmail.com>
 <CANiq72mYXnQo_Y39k23rY-rdJay8GEPJ8MhU-y7-bjkw=zRC+Q@mail.gmail.com>
 <20220407151555.GR4285@paulmck-ThinkPad-P17-Gen-1>
 <CANiq72k7BWjOU8=-dXD4bYWbK1i+rjDNaAohGrU42yJzcBm7uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k7BWjOU8=-dXD4bYWbK1i+rjDNaAohGrU42yJzcBm7uQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 07, 2022 at 07:05:58PM +0200, Miguel Ojeda wrote:
> On Thu, Apr 7, 2022 at 5:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Ah.  So you would instead look for boot to have completed within 10
> > seconds?  Either way, reliable automation might well more important than
> > reduction in time.
> 
> No (although I guess that could be an option), I was only pointing out
> that when no stall is produced, the run should be much quicker than 30
> seconds (at least it was in my setup), which would be the majority of the runs.

Ah, thank you for the clarification!

							Thanx, Paul
