Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBF0C6FD1D
	for <rcu@archiver.kernel.org>; Thu, 30 Mar 2023 08:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjC3IxB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Mar 2023 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC3Iwn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Mar 2023 04:52:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404A65AC
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 01:52:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id by8so18801799ljb.12
        for <rcu@vger.kernel.org>; Thu, 30 Mar 2023 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680166342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQMiU4eO6IqIzX6U9ZALhNg16RDYObJL4rvatOfzBLc=;
        b=JX/B4W7/+WbWtM5U3XOKPiFiCezKj6fzcnDyR3m5HUSTpvC+AhAmGNVUkxuni6G+Gt
         uv1au9kDgzQY8bsWaT/2OapZzTDYzq2s+V8nRtW09k2Qm/jlbeXzhMWCKYZ1erNgwLOQ
         NoK4StPKn9txErp6M6aIC6w72Mqdz5nVLlJwgnBarRXXcgCxrzWA1e9GfISH6KU6Hj13
         frFbJv03BXn70XqAk+34iqwqwUkAYIypp+DeF+YrybY59Ky1iePogiuIxqgef9EC/jS0
         nOOIP/YVo8CcgG/8Jr6MNsHwKSOVGlSttPooZTaMORt0fHackAy+DjZAXdY8WjRbg07n
         Y7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680166342;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQMiU4eO6IqIzX6U9ZALhNg16RDYObJL4rvatOfzBLc=;
        b=aYLUJ/DzbwwXnTeBjnET9Eg8tbfSU492yM4A5Yj50tE/1v+4CagaqciGXvR7pBRqCE
         RPglxoW3wBfHRsL46RoSzmTd+CHP8lIgH2bONe7RDtE+/HDVEQRazU6U0vyOo8GfNFKe
         ahKV4GeXCWXKWgqc+x9gp4ZBzLjfDI6WMVOAdElDggd8i4nTPiiRqPkgy9qpXocySNJz
         0VKzHHH0M2ylEJKAMxcJLqWo6QwuRJG2owQisKorWwiIxZH9KLJ32MAiz4r4H3x/9W9Y
         +cCbC+WXMt5cwxXYuVJuBiJHOj2HfhwS2Yi8PvP0erJ224tLZ1MKM8DFa4yPu1jF6gzG
         w1UQ==
X-Gm-Message-State: AAQBX9ds+abjmiaAfNosHKPMrGGEsCU96WG3NHVWFgAfBm75uoQlFnLZ
        oUR6HN7FSXFMJYDU0S/w0xs=
X-Google-Smtp-Source: AKy350YsIqJuc89DOWNSmIEmdeaurHl0rV321hXj5h5lBXNCZDMlY9OxVEK4zBTyLi/BpNJG5C3/uw==
X-Received: by 2002:a2e:8698:0:b0:29b:d488:fd87 with SMTP id l24-20020a2e8698000000b0029bd488fd87mr6511589lji.23.1680166341649;
        Thu, 30 Mar 2023 01:52:21 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id y26-20020a2e321a000000b002934febffe4sm5822604ljy.128.2023.03.30.01.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:52:21 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 30 Mar 2023 10:52:18 +0200
To:     Ziwei Dai <ziwei.dai@unisoc.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        shuang.wang@unisoc.com, yifan.xin@unisoc.com, ke.wang@unisoc.com,
        xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com
Subject: Re: [PATCH] rcu: Make sure new krcp free business is handled after
 the wanted rcu grace period.
Message-ID: <ZCVNwvhJ10iBN+wp@pc636>
References: <1680161497-19817-1-git-send-email-ziwei.dai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1680161497-19817-1-git-send-email-ziwei.dai@unisoc.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 30, 2023 at 03:31:37PM +0800, Ziwei Dai wrote:
> From: 代子为 (Ziwei Dai) <ziwei.dai@ziwei-lenovo.spreadtrum.com>
> 
> In kfree_rcu_monitor(), new free business at krcp is attached to any free
> channel at krwp. kfree_rcu_monitor() is responsible to make sure new free
> business is handled after the rcu grace period. But if there is any none-free
> channel at krwp already, that means there is an on-going rcu work,
> which will cause the kvfree_call_rcu()-triggered free business is done
> before the wanted rcu grace period ends.
> 
Right. There have to be a "Fixes:" tag.

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8e880c0..4fe3c53 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3107,15 +3107,16 @@ static void kfree_rcu_monitor(struct work_struct *work)
>         for (i = 0; i < KFREE_N_BATCHES; i++) {
>                 struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
> 
> -               // Try to detach bulk_head or head and attach it over any
> -               // available corresponding free channel. It can be that
> -               // a previous RCU batch is in progress, it means that
> -               // immediately to queue another one is not possible so
> -               // in that case the monitor work is rearmed.
> -               if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
> -                       (!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
> -                               (READ_ONCE(krcp->head) && !krwp->head_free)) {
> -
> +               // Try to detach bulk_head or head and attach it, only when
> +               // all channels are free.  Any channel is not free means at krwp
> +               // there is on-going rcu work to handle krwp's free business.
> +               if (!list_empty(&krwp->bulk_head_free[0]) ||
> +                       !list_empty(&krwp->bulk_head_free[1]) ||
> +                               !krwp->head_free)
> +                       continue;
> +               if (!list_empty(&krcp->bulk_head[0]) ||
> +                       !list_empty(&krcp->bulk_head[1]) ||
> +                       READ_ONCE(krcp->head)) {
>                         // Channel 1 corresponds to the SLAB-pointer bulk path.
>                         // Channel 2 corresponds to vmalloc-pointer bulk path.
>                         for (j = 0; j < FREE_N_CHANNELS; j++) {
> --
> 1.9.1
> 
Give me some time to have a look at your change closer. It seems it can
trigger a rcu_work even though krcp is empty. But it is from a first
glance.

Thanks!

--
Uladzislau Rezki
