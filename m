Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AEDC54EAA
	for <rcu@archiver.kernel.org>; Mon, 30 Jan 2023 15:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjA3PA6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbjA3PA5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Jan 2023 10:00:57 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258152686D
        for <rcu@vger.kernel.org>; Mon, 30 Jan 2023 07:00:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id w11so19365343lfu.11
        for <rcu@vger.kernel.org>; Mon, 30 Jan 2023 07:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t9flGG7hLPl+f0Bqit/Q9K1nyhUDfEEywIAWrZa8U+I=;
        b=yDu7O3L4w145aQfIK8WzTBC5TLyNo598BQ+AOSvadpEmPKuIRZ48IgdNP0FzbZZqxR
         wbNqkKJkbGDIfk8vPkgz/ajLbQWoO9UW/uRAeBrR8Bsz3YnAWOTw56dTr1PKE+6da2yA
         iXWE+ydY2KP8gNN8LJvPDLbE2uQ9ITXrBAU4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9flGG7hLPl+f0Bqit/Q9K1nyhUDfEEywIAWrZa8U+I=;
        b=5RPEyTQ5iPxYODPZYE9R7Nxny1Y3jHMN8bdw4ZQ/dn2PZecJdzggfhojc8i6u46e0F
         KD6kR2i4bkMLWG0hb/wyW14pRXG0D+DawJku7vQkiZHmF/bJOAMKUTKc6mEmqwWPUhx/
         cW8Xa07UVAXipKBS91k+eL/96rgqeBIetfuF2dpE/Fg1lYkjSQ3cOaaekeNNg6Y9/5YH
         CjoiXq5n4x05NG9WoA4D8Sqi769/DgttIOPHnE1NUmM7QdodwuF9ZWkeaUdbTOtCWE3p
         zvS9hchqcT4Dw3Mrk9tY8pbs+VZQs920OOjhkeZWRAOUbK1LcnJq+RTKzLWeIXqxhhD3
         FbVw==
X-Gm-Message-State: AO0yUKWvlILBWcdcRxHEr8PIX6RCWRdTVwKnieJLGEF13mXeafz+aw3G
        v5OfhHFhzgExVIkni8U9GlQHk2VA64H+D7uwAfIQUg==
X-Google-Smtp-Source: AK7set9mxZT5Aw8/FIVawoszhEYIKruznGmUEbQiD1mCtpFb/o7+kDbDlcI+A9ZZ2u6rjXnWbV/aNv8ZmCDLdpKQmGk=
X-Received: by 2002:ac2:4907:0:b0:4d8:767b:8b6b with SMTP id
 n7-20020ac24907000000b004d8767b8b6bmr69963lfi.63.1675090854426; Mon, 30 Jan
 2023 07:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20230130071737.2806534-1-qiang1.zhang@intel.com>
In-Reply-To: <20230130071737.2806534-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 30 Jan 2023 10:00:42 -0500
Message-ID: <CAEXW_YRUV_P7oEbtkRdKyRGcrWjkr9331SD4ymw_7q-54Ggx7A@mail.gmail.com>
Subject: Re: [PATCH] rcu: Register rcu-lazy shrinker only CONFIG_RCU_LAZY is enabled
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 30, 2023 at 2:12 AM Zqiang <qiang1.zhang@intel.com> wrote:
>
> The rcu-lazy shrinker is registered without CONFIG_RCU_LAZY enabled
> is meaningless, this commit therefore make rcu-lazy shrinker is
> registered only when CONFIG_RCU_LAZY is enabled.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks.

> ---
>  kernel/rcu/tree_nocb.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 9e1c8caec5ce..28c1c092817b 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1312,6 +1312,7 @@ int rcu_nocb_cpu_offload(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>
> +#ifdef CONFIG_RCU_LAZY
>  static unsigned long
>  lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
> @@ -1360,6 +1361,7 @@ static struct shrinker lazy_rcu_shrinker = {
>         .batch = 0,
>         .seeks = DEFAULT_SEEKS,
>  };
> +#endif
>
>  void __init rcu_init_nohz(void)
>  {
> @@ -1391,8 +1393,10 @@ void __init rcu_init_nohz(void)
>         if (!rcu_state.nocb_is_setup)
>                 return;
>
> +#ifdef CONFIG_RCU_LAZY
>         if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
>                 pr_err("Failed to register lazy_rcu shrinker!\n");
> +#endif
>
>         if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>                 pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
> --
> 2.25.1
>
