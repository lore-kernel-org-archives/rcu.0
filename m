Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BC2C636CC
	for <rcu@archiver.kernel.org>; Wed, 15 Feb 2023 14:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjBOO7g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjBOO7g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Feb 2023 09:59:36 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D03C0D
        for <rcu@vger.kernel.org>; Wed, 15 Feb 2023 06:59:35 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so27957063lfv.2
        for <rcu@vger.kernel.org>; Wed, 15 Feb 2023 06:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=opxKWn/3ZRZhHQW457nWgKER1yUNZeQOCSRNriqCARc=;
        b=PVbxH6CZW65pg8CssyGrSSFxPQK2Ir1CeGtsfAFBQpgCtkRrn9Cz2s02mJZq/JUQ7V
         LQGdXnViZee7L4UZEqMyoqtsiTOGLPIWS5DkUlNDo1nuaM+WUT0eKB7TcofqJfCBHeGj
         l+7KVVosXPuuzYDTuIO1kjb+GKTXJIFyN/nx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opxKWn/3ZRZhHQW457nWgKER1yUNZeQOCSRNriqCARc=;
        b=FFHKkf+Q9SFxnuAeo5o2mb4Dr0kN8gie51QpOe5B/i6FxeL7srulwIQP9O2l04ibpY
         fCKIM7yrc5SaAWL5sEkLvqo/C6swKqwsqrItyVCcXfTfYP2XtYGkg4fo5hoL/B2aMif4
         JN1yxcwQ5Ae4a1l+uVoQWC+jzG4fBs2+JObSv/dD4oBR+GUgjrnJNZxCuE/QCHlfCosn
         r6A2t4/iUERi78rhEaYS+YR6BveLkYbEEAAKkKM1sxBYFntwA5CN8fRdZ0zQNCBjXTz5
         eKiv7MpD4fdQy2SUhxLG6XRVqsp6NcTQUpSfqO+3+1I/ep4Bk16da2mjIKQgs/FJOa+I
         svaA==
X-Gm-Message-State: AO0yUKUijYSCieJZhfnMxBsRgZVvyjPVpVwXwGng4SI7cQRy5H+v7jSV
        qcIP2GLoRaSllzbAq0bZDiEHaEeGas8IpeHLfmj8kRxNT5nt0w==
X-Google-Smtp-Source: AK7set/TNpsgs9uIkss6ZBBh1xOuxN2AyeKBnaAtLWhKN7hRxuD5dT4kYFtvk88wBjijPv57kMW/m6klJIpuIaf8kfg=
X-Received: by 2002:ac2:59cf:0:b0:4d5:ca32:9bdf with SMTP id
 x15-20020ac259cf000000b004d5ca329bdfmr617970lfn.11.1676473173450; Wed, 15 Feb
 2023 06:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20230210000021.1007853-1-qiang1.zhang@intel.com>
In-Reply-To: <20230210000021.1007853-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Feb 2023 09:59:22 -0500
Message-ID: <CAEXW_YSdXWcM_WO8FNNAs_sy=d=dwd7Ox9Aayucu9hgJ9BLhHQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/isolation: Fix illegal CPU value by
 housekeeping_any_cpu() return
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 9, 2023 at 6:55 PM Zqiang <qiang1.zhang@intel.com> wrote:
>
> For kernels built with CONFIG_NO_HZ_FULL=y, running the following tests:
>
[...]
> This commit therefore add checks for cpumask_any_and() return values
> in housekeeping_any_cpu(), if cpumask_any_and() returns an illegal CPU
> value, the housekeeping_any_cpu() will return current CPU number.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/sched/isolation.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..534397ab7a36 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -46,7 +46,11 @@ int housekeeping_any_cpu(enum hk_type type)
>                         if (cpu < nr_cpu_ids)
>                                 return cpu;
>
> -                       return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +                       cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +                       if (cpu >= nr_cpu_ids)
> +                               return smp_processor_id();
> +                       else
> +                               return cpu;

Nit: no need of "else", simply:

return (cpu >= nr_cpuids ? smp_processor_id() : cpu);

or

if (cpu >= nr_cpu_ids)
   return smp_processor_id();
return cpu;

Thanks.
