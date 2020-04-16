Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F443C2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F7520786
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YhLp6OX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgDPVE2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgDPVE2 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 17:04:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C4C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:04:26 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o19so175914qkk.5
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zTjxp7v3io4d+TAB+jWmWDKQTEGkFrtPZXBYASTPzY0=;
        b=YhLp6OX5Zt3iqmVfy0c56DphC12rm977+V9+qvgsAN3mBPGE8WiEETVrjs//aKQP9P
         Fu2U3iy2kK1MmmtAaROyitaHjX1MYnGXVj1R1mdi9Cw5bMoty3vOgcdTmxu9fyI/f9wb
         Gd8JI0NPin4rrkDkSkxe9AggJC5WJ1Rd7TvwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zTjxp7v3io4d+TAB+jWmWDKQTEGkFrtPZXBYASTPzY0=;
        b=n2GT4YCNNtAxnxnezUqjIbqMe2gz/yZfq0Z9sNqm2hY0q7GT15OS1YXNIhR4fUh/uL
         thex/+f8qEVnBDsuxmwr6Z72FdU97I2XKZ8K8Q8OeKsixxSPPYN8XrvhydXt7C5DaeQk
         6zIc2rzVeJ5OMUWT2JPnBpqRBMHE2c8qO1bVz2pjQdouv2V1U5RuQyQn6ccVO55XkRf0
         KUv42voNH8AFUxAMPOaFPNBL9FtKIdWqyb2teuBa7FHHS3gKiUIfjAw5JS3JkFTicNZQ
         ESs40ml+snZ5SC2aHYgjrJJPgwhd8dGiWhF57HYd7s3Q0c28/zqx0CKUeNQomZRtp5+9
         7kng==
X-Gm-Message-State: AGi0PuapsZd9zSrjqFwRekYCUtdhYrGoi0pgjc0ORWdgNOkovPEEAWjI
        UrFYR5JDqkVr+nC+1AmnRvq3+A==
X-Google-Smtp-Source: APiQypKZIX0XB2zDlpJUOkY6Nyv0G2goizI6mYpaXtJPe8hXwyaq+GC5zDZXwasYrWQ49TmXm3EEQw==
X-Received: by 2002:a37:a8c7:: with SMTP id r190mr34408968qke.65.1587071066047;
        Thu, 16 Apr 2020 14:04:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w79sm4735559qkb.97.2020.04.16.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:04:25 -0700 (PDT)
Date:   Thu, 16 Apr 2020 17:04:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416210424.GD176663@google.com>
References: <20200416154647.ceotefna34pdxpfi@linutronix.de>
 <20200416160129.GA8337@pc636>
 <20200416161149.lkvkfwevanff36kb@linutronix.de>
 <20200416161819.GA8551@pc636>
 <20200416163302.3fsroillwk2om5dh@linutronix.de>
 <20200416172953.GR17661@paulmck-ThinkPad-P72>
 <20200416182309.zytrgowlngpewxbt@linutronix.de>
 <20200416182948.GV17661@paulmck-ThinkPad-P72>
 <20200416184348.GB149999@google.com>
 <20200416205636.fdljtricn6i3a2ub@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416205636.fdljtricn6i3a2ub@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 10:56:36PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-16 14:43:48 [-0400], Joel Fernandes wrote:
> > > Fair enough!  IIRC, get_page() uses non-raw spinlocks, so...
> > 
> > Oh, I see Paul made the same suggestion I did for raw spinlocks.
> > 
> > migrate_disable() is fine, but note that in the later code we will not be
> > sleeping even during the get_page(), so I don't see a problem with raw
> > spinlock... did I miss something?
> 
> The buddy allocator, which get_page() is using, is using spinlock_t
> which is a sleeping lock. You can't have memory allocations within a
> raw_spinlock_t section even with GFP_ATOMIC on PREEMPT_RT.

Oh, ok! Thanks for the clarification and sorry about the noise. Now I get
your motivation with the patch.

thanks,

 - Joel

