Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D5FC433FE
	for <rcu@archiver.kernel.org>; Fri, 14 Oct 2022 22:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJNWpP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Oct 2022 18:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJNWpM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Oct 2022 18:45:12 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8574731228
        for <rcu@vger.kernel.org>; Fri, 14 Oct 2022 15:45:06 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f22so4611765qto.3
        for <rcu@vger.kernel.org>; Fri, 14 Oct 2022 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wTTtDn8bMgOHPumRgeVGmfS8E9BMHk34r0/6EY7HK8=;
        b=fn+Sp8nK+zHTUKEu0/UOyIV8lH0ubMxMGI8FTL8t5mvCB+3CKr1NLT6vcv/DeD3m4i
         OLauho6n3mQht+QrGQYmub8EAOQ9IaNXNv9qRXNIyZbKaGkLg7xmxDR3qEywUr3puL3x
         g2MNZOtpJz0kIpWQup/tJynHBWGi/gjSQAWU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wTTtDn8bMgOHPumRgeVGmfS8E9BMHk34r0/6EY7HK8=;
        b=tY2q1U2819IVm6y1nfOfWbQId90N58+fXlt7qEM/iJraSl3bQNB5wzDg6IS+Jo2XYs
         ZftF1dCuAHDNCjTM7rT+mFDPQDBGTIZsUy8mTRD1l0Bis9YIFbycGLSmIv1Tf99ebNcG
         D1mCsGLVGU72539BJj22lze0W4/Bj9jFy80vAfwavbojp7mJ/9AojnhEKPNYLsJaBpnr
         a1VniqUTMmDvSpg86K8z1KCJ2AGR8SyNcpCmTRpBAeZPkmVZYxFjZAeza0ZcQIS8Moih
         Q2K/pZ/3TpwMh98jHF4mEeVvFBDF52bU72BzYg6syfNu+F//TOLJrwrRlcFxIjrKHwCl
         VX7Q==
X-Gm-Message-State: ACrzQf0+nYpuwAK8oHbKN33vYzafiy1zT4nXoQXIT/oXsDmWPtBwKkKN
        O7GdMjx4dMIcq6He/K1e/6296w==
X-Google-Smtp-Source: AMsMyM7v6wQZQjuv6d1fxvAxCjL/mv6dq9FXoigfgcYIsjgQwKkCjnv8TIlfaW5n7AjTBf7wXbWWmQ==
X-Received: by 2002:ac8:59c1:0:b0:39c:d5c3:6859 with SMTP id f1-20020ac859c1000000b0039cd5c36859mr61103qtf.230.1665787505654;
        Fri, 14 Oct 2022 15:45:05 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bc10-20020a05622a1cca00b0039ccd7a0e10sm2856195qtb.62.2022.10.14.15.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 15:45:05 -0700 (PDT)
Date:   Fri, 14 Oct 2022 22:45:04 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 1/3] srcu: Warn when NMI-unsafe API is used in NMI
Message-ID: <Y0nmcH0SktDdonyW@google.com>
References: <20221013172244.1099010-1-frederic@kernel.org>
 <20221013172244.1099010-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013172244.1099010-2-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 13, 2022 at 07:22:42PM +0200, Frederic Weisbecker wrote:
> Using the NMI-unsafe reader API from within NMIs is very likely to be
> buggy for three reasons:
> 
> 1) NMIs aren't strictly re-entrant (a pending nested NMI will execute
>    at the end of the current one) so it should be fine to use a
>    non-atomic increment here. However breakpoints can still interrupt
>    NMIs and if a breakpoint callback has a reader on that same ssp, a
>    racy increment can happen.
> 
> 2) If the only reader site for a given ssp is in an NMI, RCU is definetly
								  definitely
>    a better choice over SRCU.

Just checking - because NMI are by definition not-preemptibe, so SRCU over
RCU doesn't make much sense right?

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> 3) Because of the previous reason (2), an ssp having an SRCU read side
>    critical section in an NMI is likely to have another one from a task
>    context.
> 
> For all these reasons, warn if an nmi unsafe reader API is used from an
> NMI.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/srcutree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index c54142374793..8b7ef1031d89 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -642,6 +642,8 @@ static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
>  
>  	if (!IS_ENABLED(CONFIG_PROVE_RCU))
>  		return;
> +	/* NMI-unsafe use in NMI is a bad sign */
> +	WARN_ON_ONCE(!nmi_safe && in_nmi());
>  	sdp = raw_cpu_ptr(ssp->sda);
>  	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
>  	if (!old_nmi_safe_mask) {
> -- 
> 2.25.1
> 
