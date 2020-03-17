Return-Path: <SRS0=yil3=5C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6528C0044D
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 01:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7890206E2
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 01:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584409473;
	bh=rBk4LudtGQ8StOEQUZboIrJEdJcn1oFPjo2quqGzPDk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yEYYH8EmWwBjSWqmgspwPs9bbdQOX2UQDWsIr4ShBbhp1kO485aQl1//ZfvVS82kB
	 vRk1z49yqKwzPGQSQ36CzbrfBjcaJ9i2UIZ/lddpvPViSOstMBLPBUdoeElTPeZUIP
	 GQ0KeI2XlMxFiEoxPKEy2ByVQccNb7ivZdJGl0IE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCQBod (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgCQBod (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 21:44:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCBF20663;
        Tue, 17 Mar 2020 01:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584409472;
        bh=rBk4LudtGQ8StOEQUZboIrJEdJcn1oFPjo2quqGzPDk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZUVqgBvFMZAVFhDsEU7SKY7ky1+IMbvd95RpeQ4qwvGzTWWqiy+GCzwu6rU7K0GUe
         kmiv+7U4uZl6LDsE8qAAfxl2jN4ghIpYZAHzZ0Uzt9VuLzgaOUbsjVMEP3mAEISfPL
         /dkpdPaS28fRbrMvS11Q6NuTXZrA8nE3grGDYIwM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8F0C63522E56; Mon, 16 Mar 2020 18:44:32 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:44:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu <rcu@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: Power outage
Message-ID: <20200317014432.GE3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJzB8QEUkcfx19N5369AqvfkOfQ+DL3pEjYJsK7yJi+tSq8CFg@mail.gmail.com>
 <CAEXW_YSBe3UOWwjTBpya_bM47RvrpV8kcx=RrskPP3z0i0nY2g@mail.gmail.com>
 <20200317010805.GD3199@paulmck-ThinkPad-P72>
 <20200316213549.7c806dc9@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316213549.7c806dc9@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 16, 2020 at 09:35:49PM -0400, Steven Rostedt wrote:
> On Mon, 16 Mar 2020 18:08:05 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Mon, Mar 16, 2020 at 07:29:46PM -0400, Joel Fernandes wrote:
> > > I saw a bunch of ping timeouts on IRC and was wondering, yours among
> > > them. :-). See you soon back online!  
> > 
> > Just to add insult to injury, vger rejected the email.
> > 
> > Due to its belief that said email contained a virus.
> 
> It shouldn't have rejected it. It should have just put it under a 14
> day quarantine.

;-) ;-) ;-)

It did come through shortly after, so maybe a 140 minute quarantine?

							Thanx, Paul

> -- Steve 
> 
> 
> > 
> > You just can't make this stuff up!
> > 
