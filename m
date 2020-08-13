Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D641C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1000206B2
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 19:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS4P2T2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMTFL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMTFK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 15:05:10 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A76C061757;
        Thu, 13 Aug 2020 12:05:09 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g14so8530469iom.0;
        Thu, 13 Aug 2020 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zMhp2fumVVPLWEb4wUScwu8YBeSNbdB6g4k9dSGOidI=;
        b=QS4P2T2acqLacdF8h7yq7NKwQlZ2Vbq2p7dDflSKbNr+zhdKoqyVGaQrw88RL4bHGO
         NqougenqYFijNlnMAHcpvewcw9vF3JFHz6q0KIjYfsFim4UpbeOwfpUM8dAVuOvteJra
         vXaOGbj+PUJ+o0VkGRXz3NCk36ODuCbfE3TpVkVS8PXub1u5UD7mEsXVUkwQ0ixyXGlM
         Cq9uKRXOTCCWPHhTox9nYgQojqyuBb1QJVSyoUZ0913NXvZOH36d3XbFsikViX6Ci602
         YR1UiAXePTj0U23fer568k/cU+9ToAr8/IVZwlmJ7i1Fsz5SBn1sj1iE3vB07zM50YaQ
         HJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zMhp2fumVVPLWEb4wUScwu8YBeSNbdB6g4k9dSGOidI=;
        b=aBr8HEXudm1qAXzCv7jTQd6UAfEothZIbSUyxsbi6Uv8Zx+YtmeeXd6NgvEcL1U1D1
         ComAQab6wOzr1qD/4+ALnlUCVcRRO94GX0pwBJpnkRdiIqcUfdjlZpzebeE61ISEXMBU
         dMsy198vt4JL6t8GGPbu02XSaRt5ZgiZoO7ra9HNgXrciQatitEIufRWtyDXNW6oaMEK
         U6GQ8wT4hPBm4h7fY35cdruadSpBxGmMUR9jNUJ6f6Qksw140rS3uueFBLyb48H/ksBH
         GKNdz7ha6vyLBM7eKApfa+HuXNOAId8YZDP5SwiWptphq6w1Ik4FgfHoiMj7mf55PoPq
         i3Cw==
X-Gm-Message-State: AOAM533Kwr869ZE9e0E81Fli58c4K04L32oqbh7YkUXLQ+S1bKIuLArL
        66kd/8tN15Le+XLlHMVSkzAFzezOcH1heIVnqUk=
X-Google-Smtp-Source: ABdhPJyDSqG2C0hIzDC/Jk/fSLu/HZL3ahHx0IGBHT0UtW2S4rgrzdXiwVm1sG9jvgXTfwbXjJ/+62sjQDZyeZg0lTo=
X-Received: by 2002:a5d:80ce:: with SMTP id h14mr6268664ior.12.1597345509136;
 Thu, 13 Aug 2020 12:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200812095639.4062-1-xiangxia.m.yue@gmail.com>
In-Reply-To: <20200812095639.4062-1-xiangxia.m.yue@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 13 Aug 2020 12:04:58 -0700
Message-ID: <CAM_iQpWUP11mGwXPB=JKsT2=zhyUEf-udXp9YNYS_Fdt73knmg@mail.gmail.com>
Subject: Re: [PATCH v2] net: openvswitch: introduce common code for flushing flows
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?B?Sm9oYW4gS27DtsO2cw==?= <jknoos@google.com>,
        Gregory Rose <gvrose8192@gmail.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, dev@openvswitch.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 12, 2020 at 2:59 AM <xiangxia.m.yue@gmail.com> wrote:
>
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>
> To avoid some issues, for example RCU usage warning and double free,
> we should flush the flows under ovs_lock. This patch refactors
> table_instance_destroy and introduces table_instance_flow_flush
> which can be invoked by __dp_destroy or ovs_flow_tbl_flush.
>
> Fixes: 50b0e61b32ee ("net: openvswitch: fix possible memleak on destroy f=
low-table")
> Reported-by: Johan Kn=C3=B6=C3=B6s <jknoos@google.com>
> Reported-at: https://mail.openvswitch.org/pipermail/ovs-discuss/2020-Augu=
st/050489.html
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks.
