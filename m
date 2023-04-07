Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79BDC76196
	for <rcu@archiver.kernel.org>; Fri,  7 Apr 2023 11:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbjDGLXQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Apr 2023 07:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbjDGLXN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Apr 2023 07:23:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37CE5FF9
        for <rcu@vger.kernel.org>; Fri,  7 Apr 2023 04:23:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sg7so7717358ejc.9
        for <rcu@vger.kernel.org>; Fri, 07 Apr 2023 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680866591; x=1683458591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTe4A7c2wtes4OyLAlqz1Su81R2SvcN0e2w8e/6ccTI=;
        b=Ke5ZjbtuPosLIT4aQcvEPv3fw3ws6Ol2bmEw+Vt40TR2jk426NrcdYNNLCaRLbdEn3
         t8ITJHK9uoZLYyWsWABE2rxAjuJH/GjN6PwPEawzOXcDBhmdN33SMDeu8bJws23e55UY
         yTZIHy1K7AnJNoCk/tYP10HSdpb8GQyO42O5y3Oap+y5h56X4rK/cF6g2XXFoHsB4ucE
         iPLC/UH8GDvk48iPG4pwvSM8nvzxh4WrFvns48Z92kRcSNpZFp9rl3+HxSaUMXabsqAU
         tPGndZbMEwxTrnew7yPWF0Nq+ygyxcbEfFHctQB2kCZ17d5WycjcqHxct8+//4zMtq09
         rhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680866591; x=1683458591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTe4A7c2wtes4OyLAlqz1Su81R2SvcN0e2w8e/6ccTI=;
        b=myQp8LlIFUwmoHX4LzmTT/krmQTmRKsIISL8gW1kC3sBqi2/Si1yGZjfOxsdByt04P
         lrYW0WKzsLx7SlQ43GB6vuVu3f/V1BfTf3VEgZBaWbCcOdgcOyJoP01WTlOHLte/MNBz
         mrtIRfiphWMR59qdDIq3AyYS1zZe9qeGOoUNB3tgN9i0HUN4G11U3HbyCrtTu1ZDDSkJ
         iE14zzVDevlpFX0uhc1Bq5lrRykgT6BysuXMO76FV2TbI5/X2GMcwGqrgWe48RilkDrq
         Bk97/RmwMXbrHQE8kbQ9Fvlt7Ok0Y8jU3yGioFSoLAxOHESCWBMwQ+E/bWgfoX92Svbc
         OB9Q==
X-Gm-Message-State: AAQBX9czZXMssRMiNj40XB/fl4SZTACzJA+UvtxcGyd3IxuEZdaAlbMN
        V5Ccq75TsqiZLQfSN/5dBJGH9YoIAQSWRA==
X-Google-Smtp-Source: AKy350Y8WSBdysXiTuuTycfeacl4IdJ1f6kE26v7X25dLN2ub00Zj9UGayq2YV0cgU1vctW0T2w6DA==
X-Received: by 2002:a17:907:2c44:b0:90b:167e:304b with SMTP id hf4-20020a1709072c4400b0090b167e304bmr1734368ejc.45.1680866591112;
        Fri, 07 Apr 2023 04:23:11 -0700 (PDT)
Received: from pc636 (49-224-201-31.ftth.glasoperator.nl. [31.201.224.49])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906091300b00923f05b2931sm1949132ejd.118.2023.04.07.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:23:10 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 7 Apr 2023 13:23:09 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     urezki@gmail.com, rcu@vger.kernel.org
Subject: Re: Kerneldoc fix to fold in
Message-ID: <ZC/9HWX5LzSAiW3H@pc636>
References: <906701b3-cedb-4e26-944e-f91ebf06a334@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <906701b3-cedb-4e26-944e-f91ebf06a334@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 06, 2023 at 11:14:30AM -0700, Paul E. McKenney wrote:
> Hello, Uladzislau,
> 
> Would the patch below (to be folded into your original) be a good fix
> for the kerneldoc issue Stephen Rothwell pointed out?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 7873a901c00f5c6d0f5b5b979584b4c7f1294563
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Apr 6 11:06:26 2023 -0700
> 
>     squash! rcu/kvfree: Add debug check for GP complete for kfree_rcu_cpu list
>     
>     [ paulmck: Fix kerneldoc issue raised by Stephen Rothwell. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9cc0a7766fd2..1be23a64f027 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2795,6 +2795,7 @@ struct kvfree_rcu_bulk_data {
>   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
>   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
>   * @head_free: List of kfree_rcu() objects waiting for a grace period
> + * @head_free_gp_snap: Grace-period snapshot to check for attempted premature frees.
>   * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
>   * @krcp: Pointer to @kfree_rcu_cpu structure
>   */
>
Absolutely.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
