Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E8EC004D4
	for <rcu@archiver.kernel.org>; Fri, 20 Jan 2023 01:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjATBrV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 20:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATBrU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 20:47:20 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169EF9EE25
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 17:47:19 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d16so3130671qtw.8
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 17:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyQbDs7HBixw8EukE3w9IBEC2xEjoX+NR7SoW/oXAGU=;
        b=K+b24l2HVndz0EyvMYAjay5yVALhz1Uft+YM2lg2Edz2+qN36ESe4PWhA68/w93wZp
         BNgDLzk41hB373N7WdDwPcjKH8t5OOgFUFYFiAvDV2h66FgZ+jRm62UNCGu0eBtI145L
         /6551RJlUmyIIe6OE0wfYeRC72ZMqOuEwD2Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyQbDs7HBixw8EukE3w9IBEC2xEjoX+NR7SoW/oXAGU=;
        b=CHqSK9LkPEKBSKvs2kjVKzhwV6+dXEGyiOcxv7OFuHnqPG3bZrN0MR/+ogLoDKEDYM
         uiQr6m8xIfROIAe67gfFiUtlZYmfEk2YuGq1Gas0wu9ITK07EkE+gVRZ/PJOBaiambKR
         sVoj6fg659fdaL5i4Wz1IkhDR4jrGQwL0FJ3RC5Q6/1ZV2SjXBnOSUD0+oFbnK1hxYJM
         WRTkqIrE9E8DzV8APilqfxc+iQa/qgyfe3p/JUNGCBxQ/0p4/30WFWZfQ8MY25MYQtM9
         Z3/I6pUD2bsv10NRWyeHO3byaurEevZS7yYkm8uUywKK0tspAyHAPMvhDChD8oHkFjLc
         VaxQ==
X-Gm-Message-State: AFqh2koFYQbBPuFEh47xsqwPYHSEQ2YKkaDDxb1ISAj37wh/SkJ+BQtx
        iHTzrESx+DpEGbWdB0xlUTNiWq7vAl5Qc2xR
X-Google-Smtp-Source: AMrXdXvi1nG1kiSvrD1IzqiCTywY2pJQ5RTLVG7BHlyu2RujlizVTf64VYsUFdd4syrV8re6MbvGGw==
X-Received: by 2002:ac8:534b:0:b0:3a9:6b48:a13c with SMTP id d11-20020ac8534b000000b003a96b48a13cmr17687316qto.51.1674179238125;
        Thu, 19 Jan 2023 17:47:18 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id hg20-20020a05622a611400b003a81eef14efsm19714182qtb.45.2023.01.19.17.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:47:17 -0800 (PST)
Date:   Fri, 20 Jan 2023 01:47:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] rcu: Further comment and explain the state space of GP
 sequences
Message-ID: <Y8nypBG5k+D3YXHO@google.com>
References: <20230119141134.686626-1-frederic@kernel.org>
 <Y8lQjKKDd0G2zt3F@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lQjKKDd0G2zt3F@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 19, 2023 at 03:15:40PM +0100, Frederic Weisbecker wrote:
> On Thu, Jan 19, 2023 at 03:11:35PM +0100, Frederic Weisbecker wrote:
> > The state space of the GP sequence number isn't documented and the
> > definitions of its special values are scattered. Try to gather some
> > common knowledge near the GP seq headers.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 115616ac3bfa..fb95de039596 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -14,6 +14,39 @@
> >  
> >  /*
> >   * Grace-period counter management.
> > + *
> > + * The two lowest significant bits gather the control flags.
> > + * The higher bits form the RCU sequence counter.
> > + *
> > + * About the control flags, a common value of 0 means that no GP is in progress.
> > + * A value of 1 means that a grace period has started and is in progress. When
> > + * the grace period completes, the control flags are reset to 0 and the sequence
> > + * counter is incremented.
> > + *
> > + * However some specific RCU usages make use of custom values.
> > + *
> > + * SRCU special control values:
> > + *
> > + * 	SRCU_SNP_INIT_SEQ	:	Invalid/init value set when SRCU node
> > + * 							is initialized.
> > + *
> > + * 	SRCU_STATE_IDLE		:	No SRCU gp is in progress
> > + *
> > + * 	SRCU_STATE_SCAN1	:	State set by rcu_seq_start(). Indicates
> > + *								we are scanning the inactive readers
> > + *								index.
> > + *
> > + *		SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
> > + *								Indicates we are flipping the readers
> > + *								index and then scanning the newly inactive
> > + *								readers index.
> > + *
> > + * RCU polled GP special control value:
> > + *
> > + *	RCU_GET_STATE_COMPLETED :	State value indicating that a polled GP
> > + *								has completed. It's an absolute value
> > + *								covering both the state and the counter of
> > + *								the GP sequence.
> >   */
> >  
> >  #define RCU_SEQ_CTR_SHIFT	2
> > -- 
> > 2.34.1
> > 
> 
> Ok perhaps this one got the tabs right:
> 
> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Thu, 19 Jan 2023 14:29:34 +0100
> Subject: [PATCH v2] rcu: Further comment and explain the state space of GP
>  sequences
> 
> The state space of the GP sequence number isn't documented and the
> definitions of its special values are scattered. Try to gather some
> common knowledge near the GP seq headers.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 115616ac3bfa..fb95de039596 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -14,6 +14,39 @@
>  
>  /*
>   * Grace-period counter management.
> + *
> + * The two lowest significant bits gather the control flags.
> + * The higher bits form the RCU sequence counter.
> + *
> + * About the control flags, a common value of 0 means that no GP is in progress.
> + * A value of 1 means that a grace period has started and is in progress. When
> + * the grace period completes, the control flags are reset to 0 and the sequence
> + * counter is incremented.
> + *
> + * However some specific RCU usages make use of custom values.
> + *
> + * SRCU special control values:
> + *
> + * 	SRCU_SNP_INIT_SEQ	:	Invalid/init value set when SRCU node
> + * 					is initialized.
> + *
> + * 	SRCU_STATE_IDLE		:	No SRCU gp is in progress
> + *
> + *	SRCU_STATE_SCAN1	:	State set by rcu_seq_start(). Indicates
> + *					we are scanning the inactive readers
> + *					index.
> + *
> + *	SRCU_STATE_SCAN2	:	State set manually via rcu_seq_set_state()
> + *					Indicates we are flipping the readers
> + *					index and then scanning the newly inactive
> + *					readers index.
> + *
> + * RCU polled GP special control value:
> + *
> + *	RCU_GET_STATE_COMPLETED :	State value indicating that a polled GP
> + *					has completed. It's an absolute value
> + *					covering both the state and the counter of
> + *					the GP sequence.
>   */

Other than the minor comments in the other thread:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  
>  #define RCU_SEQ_CTR_SHIFT	2
> -- 
> 2.34.1
> 
