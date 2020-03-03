Return-Path: <SRS0=TlEe=4U=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F970C3F2D1
	for <rcu@archiver.kernel.org>; Tue,  3 Mar 2020 22:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB24320866
	for <rcu@archiver.kernel.org>; Tue,  3 Mar 2020 22:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyJruACF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgCCWlL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:41:11 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:35798 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWlL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Mar 2020 17:41:11 -0500
Received: by mail-lf1-f52.google.com with SMTP id z9so4209859lfa.2;
        Tue, 03 Mar 2020 14:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PCjToRekaqNSdWUmgH5POUBnwr1l0aeVSOTIZP57hM=;
        b=NyJruACFquysQrXD3/z7qK754PnTA2hVNEcXJyP9Biy8OvLwJ4o0gUuJN+2qQnbLbH
         lZvhQrrnRuIgNPrAgfJ1XesP/B3J1CWviwHAfwjuMdiWz/nIZvZTecpVUGm22kcDEuxt
         cKN5tyDVfOTZ7rKdyQc6HTxzwBzRozIIUu6qUgifA2faLtc1shi//CXGSUExMld+FqfX
         jvBbq2B2sHt82DK9gxPS83sPtPjlCmlPm6lVml+IhEAbkeM0hkDl2pYfC/5EfOqwRkLE
         3zB8UUvcw9k9FXS2xugIiDKvqMUImTRjaMa30KNwwTq/V6OzcW95tFW9fwz6Fub6iODt
         SdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PCjToRekaqNSdWUmgH5POUBnwr1l0aeVSOTIZP57hM=;
        b=o70Ns19oYseITru0Kv3jXqfaUgMkSQVYnuwSKTB9Lo7dtp3bub/5wceUf7HD5Qsafk
         9CKox0pBbZJwsFHn7e/EpRghBBs1WdbsGkkQWYXoi73iCBZ1KOHXe21TsnnJMTCyer0F
         iUdIpaF9iGI+icOglCdSaAcIFYbgt9rhbyItcJNMeABotchITsJLq/SuPwB+2NKdsguz
         sgpjHf8j5PwM1mqsYbVeM3jFjvxVOgvBWf4SN4seSkPqVLCe4iO4hdmJvBNEtC6+sn1I
         Smu11YtN9E8SH/Y+TV2zJPwpizdSC6rM1Ie51dKrPuLlt3e5eGvGLbs80gAz+e2lrwqm
         RNBw==
X-Gm-Message-State: ANhLgQ1xZF3wJovEfs3cFTW9MW9eBVwVLFPt8HcVFz9kCe87aTkmR2Ra
        j0kOmNvsvjp8hcWJCx+d9s2/NAGHNsgbuLWqQ9M=
X-Google-Smtp-Source: ADFU+vvkoJDn/15/TNMvuE5JSLmVfKoU8XmNW/UVTIf0NmEFrvcr6wE1v6g7UZZAHE3IhxvHv0KeNmU74HN3szTLaPk=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr110507lfb.69.1583275268978;
 Tue, 03 Mar 2020 14:41:08 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5CrvxZDuRfBvwLV6uJJwtPuj1-vqoELKP3j15k3TbSjyg@mail.gmail.com>
 <20200229232215.GN2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200229232215.GN2935@paulmck-ThinkPad-P72>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Mar 2020 19:40:56 -0300
Message-ID: <CAOMZO5CZyubmX=1_UgTE+trag0vsNz9AYuaVcPxp7ZfvjUyYAQ@mail.gmail.com>
Subject: Re: rcu_sched stalls on 4.14
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Sat, Feb 29, 2020 at 8:22 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> In the above stack trace, the stalled CPU (that is, CPU 0) is in the idle
> loop, correct?  Then it took an interrupt and was processing softirqs
> upon return from that interrupt when it took a scheduling clock interrupt,
> which did the self-reported stall warning.
>
> Is this analysis correct?

Yes, I think so.

> If so, and assuming that this is reproducible, I suggest building your
> kernel with CONFIG_RCU_EQS_DEBUG=y, which enables additional debugging
> that might be helpful with this issue.

Will ask the reporter to try it. I haven't been able to reproduce it myself.

Thanks
