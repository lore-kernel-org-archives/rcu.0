Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C3EC433F5
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 14:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiENOeB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiENOeA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 10:34:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F8A1E3F3
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:33:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k8so9373080qki.8
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=laRnhMYA2LOBXZpzjqIFlQzIJosJhs676aMF7b8C/lc=;
        b=gbJwbc9GvcJ+oiqJvBYJ0ogS3KWRNEcs7/dR06mA3AkzGQ9N0PhFHeapYGFzGHCvHk
         iHAQ2dvc9x/7ER3VHwmjWNrKBJdztc2qhU1vei8nag1WFZ3Q4lqSL7+Mb6XihcS9FKoF
         vvwk5+az96P5OkuatpFdjb0nbmOysSe4jiouI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=laRnhMYA2LOBXZpzjqIFlQzIJosJhs676aMF7b8C/lc=;
        b=q+TbawwQzz9OSKZqk6ipbMr4tECB4NjF9meKsAwz+gQN1I7miIC37VaaRCetCeiHAp
         aSJa+QnaTDDENI9DKGmj6HwxvV0GDQP62BK7Xf4RgZxcYp1d/uRmM9hflZwUebR+D4Aj
         MPaA6ImAMzEHcE46i5o66NbURaDMa8Oo6wwoxScNbSN9rjSnCwqUJ6J0sPxagqIOoF0m
         /eHqou/2U/hIzopTUIxb+8L9etzdrMUocTBMGCHmHAUzbc9ZvFvoETZpNNxjj9SFe+Sg
         8/JQJz6yFI7g1l+QGGp84qBsfDoNgn0BfUgILNjcxbJlL76C8XUX/8m8O0C5tgMqJW30
         Qa3Q==
X-Gm-Message-State: AOAM533DbZblFCURJlQezYhc4yd9jJS6/gwlxKlLNRsgzLAGJYi/GnnM
        hCTRgAkNmzOZtK25vxQcyAOO0w==
X-Google-Smtp-Source: ABdhPJwI1jFh489f79TZb9Xzy2gZSMB/Oj0ke0Zt6ThTdCjPuIDRBhu6pgp8zilbOMQLuK2LO2fOAQ==
X-Received: by 2002:a05:620a:4509:b0:6a0:25a5:6642 with SMTP id t9-20020a05620a450900b006a025a56642mr6930565qkp.197.1652538837910;
        Sat, 14 May 2022 07:33:57 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id s20-20020ac87594000000b002f39b99f6acsm3136905qtq.70.2022.05.14.07.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:33:57 -0700 (PDT)
Date:   Sat, 14 May 2022 14:33:57 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 10/14] kfree/rcu: Queue RCU work via
 queue_rcu_work_lazy()
Message-ID: <Yn+91Q3fgteCj+td@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-11-joel@joelfernandes.org>
 <20220513001206.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yn5xZkENgmnd7wyq@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn5xZkENgmnd7wyq@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 13, 2022 at 04:55:34PM +0200, Uladzislau Rezki wrote:
> > On Thu, May 12, 2022 at 03:04:38AM +0000, Joel Fernandes (Google) wrote:
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Again, given that kfree_rcu() is doing its own laziness, is this really
> > helping?  If so, would it instead make sense to adjust the kfree_rcu()
> > timeouts?
> > 
> IMHO, this patch does not help much. Like Paul has mentioned we use
> batching anyway.

I think that depends on the value of KFREE_DRAIN_JIFFIES. It it set to 20ms
in the code. The batching with call_rcu_lazy() is set to 10k jiffies which is
longer which is at least 10 seconds on a 1000HZ system. Before I added this
patch, I was seeing more frequent queue_rcu_work() calls which were starting
grace periods. I am not sure though how much was the power saving by
eliminating queue_rcu_work() , I just wanted to make it go away.

Maybe, instead of this patch, can we make KFREE_DRAIN_JIFFIES a tunable or
boot parameter so systems can set it appropriately? Or we can increase the
default kfree_rcu() drain time considering that we do have a shrinker in case
reclaim needs to happen.

Thoughts?

thanks,

 - Joel

