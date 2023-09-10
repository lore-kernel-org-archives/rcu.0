Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C315BC71153
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 23:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjIJXCR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 19:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIJXCR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 19:02:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D668B128
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 16:02:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34df2a961a0so13900045ab.2
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 16:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694386930; x=1694991730; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUfsLtxjsDsTL/aOk61RcZvjLliQiBY/IA6Vncyrpm8=;
        b=ewQmKebopHJCX+0hlLPpzw4QsjlYrmiYWYhImjBIgrFgvAdpWsiVNNR0rws8bbeIW0
         VhVKEpb+F+Bhp/f8wUFh2KhecKKrM3e9RUdVU8+V+gOq1yJRNhry4xAnjkIK7OCb9GuH
         1DfxdYcSe2gDkdNiIRRVLtrORfjnb/pM5o/5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694386930; x=1694991730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUfsLtxjsDsTL/aOk61RcZvjLliQiBY/IA6Vncyrpm8=;
        b=jrnWT8XMg6Ke44H6f4C9Dx1CaKuZPGmu9QqK0yd+1R8VoGIObu3LeuF7k9VPrCzIgo
         pKi22GcWd7ryxIc6blbzQAB2iy3/H2NvwooTvB3hpB8JivtB62s4qeEdAMvBMSIqJKYH
         9hgL7vfLJynY6DonLRc1NbOW6hZ5qQmTH69njkNNXgaAe50x7nn0fc1w/CadUWxCQgAm
         huYrX8eE4KBAQJDU9B3XezTopO97LCFV3XuuYR9S0WhfUCKTjVK+dFMx6llXWb4WejA+
         Z/jfqV3D1DNafZqJiyDzaIVTlg8d2YvTOuN2kL6C7TuNPysUF5MS/VqRURN6keuVPe1K
         bJ9Q==
X-Gm-Message-State: AOJu0YwgIgiwxiyXHUTvPbjcvGPRYNgL5X8H4n7AXyaG512qZL5XNX4l
        lGYf1i3HbCUUf/29vyKSa0fWsjipVZc7/W4nyNE=
X-Google-Smtp-Source: AGHT+IGT22CCCCV25Rt/AXm9/Lwyj/125JMtZK9PpnTeAN4o16Nm8cSLlHSbSUdilaO2LnVjIZs23A==
X-Received: by 2002:a92:c5a5:0:b0:34f:7a25:eef3 with SMTP id r5-20020a92c5a5000000b0034f7a25eef3mr1251846ilt.26.1694386930570;
        Sun, 10 Sep 2023 16:02:10 -0700 (PDT)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id l3-20020a056e0205c300b003459023deaasm1995371ils.30.2023.09.10.16.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 16:02:10 -0700 (PDT)
Date:   Sun, 10 Sep 2023 23:02:09 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Subject: Re: [BUG] NOHZ tick-stop error: local softirq work is pending
Message-ID: <20230910230209.GA1832306@google.com>
References: <CAEXW_YTMCsaaZtyG46tjLv6En7Br0J6SD3WuLCZGhF=tSva26g@mail.gmail.com>
 <4673a906-1baa-41cf-8fd3-7d28fdd0a820@paulmck-laptop>
 <ZP4mRzlA4uCs6-Tk@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZP4mRzlA4uCs6-Tk@localhost.localdomain>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 10, 2023 at 10:25:43PM +0200, Frederic Weisbecker wrote:
> Le Sun, Sep 10, 2023 at 03:21:33AM -0700, Paul E. McKenney a écrit :
> > On Sat, Sep 09, 2023 at 10:28:36PM -0400, Joel Fernandes wrote:
> > > Hi Paul, Frederic, ever since this recent patch got merged into all
> > > recent stables:
> > > https://lore.kernel.org/all/20230818200757.1808398-1-paul.gortmaker@windriver.com/
> > >  ..
> > > 
> > > .. I am seeing this happen a lot now causing rcutorture failures:
> > > "NOHZ tick-stop error: local softirq work is pending"
> > > 
> > > It looks like the "tick-stop error" as local_bh_blocked always returns
> > > false on !PREEMPT_RT, so that patch itself seems correct.
> > > 
> > > However, it appears the string in console-badness.sh is different:
> > > 
> > > console-badness.sh:grep -v 'NOHZ tick-stop error: Non-RCU local
> > > softirq work is pending, handler'
> > > 
> > > So the string in the script needs an update?
> > 
> > Looks like it, though I believe that there is a fix in the offing,
> > at which point that "grep -v" should just be removed.  Depending on
> > timing, of course.
> 
> Yep I have a pending fix for that, will post soonish. The grep will still
> make sense afterward though.

I was wondering why the grep -v will still make sense if the pending fix
works. Or is there another legitimate reason for the string to appear?

Either way, looking forward to the patch!

thanks,

 - Joel

