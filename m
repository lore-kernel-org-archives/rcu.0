Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36334EB64D7
	for <rcu@archiver.kernel.org>; Mon, 26 Jun 2023 15:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjFZPml (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjFZPmk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Jun 2023 11:42:40 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91931125;
        Mon, 26 Jun 2023 08:42:32 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3f6a494810fso29569541cf.1;
        Mon, 26 Jun 2023 08:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794151; x=1690386151;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap4DruT+cyDgrBMqJwnVuTsbMhGM8HZMK/LnC9Abfxs=;
        b=Novx5lHXJ6+qo7KJo5MYZCuezDn4fIAK9bsFd5i+L+tNGcLw5JMWhRujMoV7IrCEyA
         sUP/O3Ey4VOhrf3Ipj47zqGutsLHjtzymT/6l3YDL4r5EWKWiR1+KacvUQXkMmNje1J1
         VyDhjNRXPqXSVb3G76SWykJthdITjR98TFOWz30Yk+emQVRWPd2+HgLKJaJUXhISkia+
         kJXf1RiKCn+U8CJxAWaPb33xit8VvFH4IIm4PfNBLaBShm4YXYzFlWU197c/wcbggmdn
         N7Nw1RoKRi/B6JeUKka+7fujarJLvmYHS7l9Tf1m8Gl5bBL6zbvlJGxTYjT9HDxRgVus
         lOrw==
X-Gm-Message-State: AC+VfDwomlKgW902m7QmGnFM5yVLq+6TuuSIf+jiZSeArHlpYdA2XGha
        y/zY+vJpPmbbvpWM/myE1UU=
X-Google-Smtp-Source: ACHHUZ5boGjjUkA+gl9piYvoZjvqv1E2JNkSSPKnsfHtG4KSKTibJEnMUN9AIZOFkT53kwjUgPmb0g==
X-Received: by 2002:a05:622a:2d3:b0:400:8b1f:dc3b with SMTP id a19-20020a05622a02d300b004008b1fdc3bmr12125117qtx.31.1687794151411;
        Mon, 26 Jun 2023 08:42:31 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:58aa])
        by smtp.gmail.com with ESMTPSA id l25-20020ac848d9000000b003f7369c7302sm3170433qtr.89.2023.06.26.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:42:31 -0700 (PDT)
Date:   Mon, 26 Jun 2023 10:42:28 -0500
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     daniel@iogearbox.net, andrii@kernel.org, houtao@huaweicloud.com,
        paulmck@kernel.org, tj@kernel.org, rcu@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 13/13] bpf: Convert bpf_cpumask to
 bpf_mem_cache_free_rcu.
Message-ID: <20230626154228.GA6798@maniforge>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-14-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624031333.96597-14-alexei.starovoitov@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 23, 2023 at 08:13:33PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Convert bpf_cpumask to bpf_mem_cache_free_rcu.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: David Vernet <void@manifault.com>

LGTM, thanks for cleaning this up. I left one drive-by comment /
observation below, but it's not a blocker for this patch / series.

> ---
>  kernel/bpf/cpumask.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 938a60ff4295..6983af8e093c 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -9,7 +9,6 @@
>  /**
>   * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
>   * @cpumask:	The actual cpumask embedded in the struct.
> - * @rcu:	The RCU head used to free the cpumask with RCU safety.
>   * @usage:	Object reference counter. When the refcount goes to 0, the
>   *		memory is released back to the BPF allocator, which provides
>   *		RCU safety.
> @@ -25,7 +24,6 @@
>   */
>  struct bpf_cpumask {
>  	cpumask_t cpumask;
> -	struct rcu_head rcu;
>  	refcount_t usage;
>  };
>  
> @@ -82,16 +80,6 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
>  	return cpumask;
>  }
>  
> -static void cpumask_free_cb(struct rcu_head *head)
> -{
> -	struct bpf_cpumask *cpumask;
> -
> -	cpumask = container_of(head, struct bpf_cpumask, rcu);
> -	migrate_disable();
> -	bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
> -	migrate_enable();
> -}
> -
>  /**
>   * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
>   * @cpumask: The cpumask being released.
> @@ -102,8 +90,12 @@ static void cpumask_free_cb(struct rcu_head *head)
>   */
>  __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
>  {
> -	if (refcount_dec_and_test(&cpumask->usage))
> -		call_rcu(&cpumask->rcu, cpumask_free_cb);
> +	if (!refcount_dec_and_test(&cpumask->usage))
> +		return;
> +
> +	migrate_disable();
> +	bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
> +	migrate_enable();

The fact that callers have to disable migration like this in order to
safely free the memory feels a bit leaky. Is there any reason we can't
move this into bpf_mem_{cache_}free_rcu()?
