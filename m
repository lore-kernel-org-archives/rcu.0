Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A702FC433FE
	for <rcu@archiver.kernel.org>; Tue, 18 Oct 2022 01:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJRB54 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJRB5z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Oct 2022 21:57:55 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891575395
        for <rcu@vger.kernel.org>; Mon, 17 Oct 2022 18:57:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x13so7850935qkg.11
        for <rcu@vger.kernel.org>; Mon, 17 Oct 2022 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYBybDD0u6tBbkRf/y6+33fBQuf81SuzZ3qkKShzqXo=;
        b=p+dXBnaxZehl4mOjVDpE2yLZ0KftYMUKql3vXjTCmM8Z+qHqGelLFBsl9c0/m4hOrl
         10I2LqYvX8mu5Bh6o5k5XOhpC2x8WEZsB9GyTBYNnNR0xFDvxyPRi9xc0reVAKLB8bkI
         O9BV/ExKagQ+2zvxw4NxT9nboJpr/FC/I6nAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYBybDD0u6tBbkRf/y6+33fBQuf81SuzZ3qkKShzqXo=;
        b=qaNdhgf0w6Z2AnDZ1/Umy599XhwMf82c9SmezZ4KI90Xqz0VMI2qwi1tly43XMaUaY
         WWxUwn7WZyzryftrmX1bMMEyVokIu2FzqG2KeSVVqSVi5tIL/7gcL0uj9S8gqyOtlOtS
         TH4W0mLDMGvPHlMcw1B//HD2R9ZTKfvxTxUR3R8CDJUnSp+x1xJ1dykVKceTB0UyT1Y8
         /8wkdDH7AzrIvhVW5y7fxBfQVNUauhRctJTSNEOzE8yLJqLoXshb5yrKzGJ+e12GM3mC
         et71SgtQjXe0e6pMzjl4Ak1tUsvYAPFs4yBBNa+GFR3hwwOgwpe/V4q/ErdutYQqMkRQ
         5p+g==
X-Gm-Message-State: ACrzQf2JTuQxTFVlML3hUCcPfk6uZXALgKg+FWqWOInpwex/+HwUWpwi
        hO51Pab6Bhwn6wYhLsb+O2+kHqlU9+gLxw==
X-Google-Smtp-Source: AMsMyM7H8PCmJN/9txCa9cXhPqnjtQrTU1FftHwRYLb3DfXTYtJFyyFGrYYqrEaG3KfahdnzGa+BqA==
X-Received: by 2002:ae9:ef04:0:b0:6ea:adcf:4c02 with SMTP id d4-20020ae9ef04000000b006eaadcf4c02mr345852qkg.779.1666058265413;
        Mon, 17 Oct 2022 18:57:45 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bp17-20020a05620a459100b006ce3f1af120sm1275114qkb.44.2022.10.17.18.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 18:57:45 -0700 (PDT)
Date:   Tue, 18 Oct 2022 01:57:44 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Export srcu_check_nmi_safety() to modules
Message-ID: <Y04IGLudV7tYORUd@google.com>
References: <20221018013906.3890007-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018013906.3890007-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 18, 2022 at 09:39:06AM +0800, Zqiang wrote:
> When enable CONFIG_PROVE_RCU and built modules, the following
> error appear:
> 
> ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
> ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!
> 
> This commit fix it by exporting the srcu_check_nmi_safety().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  kernel/rcu/srcutree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 382236dd5e46..bcd629f5f902 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -651,6 +651,7 @@ void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
>  	}
>  	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
>  }
> +EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
>  #endif /* CONFIG_PROVE_RCU */
>  
>  /*
> -- 
> 2.25.1
> 
