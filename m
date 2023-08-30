Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D82C83F19
	for <rcu@archiver.kernel.org>; Wed, 30 Aug 2023 18:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbjH3Sr7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244397AbjH3NJn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Aug 2023 09:09:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1341185
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 06:09:40 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bd0d19a304so52494031fa.1
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693400979; x=1694005779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UTTWFj2vKP575z4DigdGNUxxYXECz/tkiCbjV/NlsQ=;
        b=YEfqzUX0PinnIG6JUOKqSyJ+a6Whay2re+eB/UNZwI9oHf6bzX1gYrTSfY3h8ky4Yu
         cM2vkklpamm6PVzujlpyKbniUoNCdGF9uL4RzsNGTC81JWsAczAwiBYM4x7lH7UluLzZ
         HClUXv9ayTk3BVaHDfpgeK2JtVCuwIlYXSoS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400979; x=1694005779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UTTWFj2vKP575z4DigdGNUxxYXECz/tkiCbjV/NlsQ=;
        b=CdkSBn/cxThTvnkczkf8tyao7nI7MdbF3/28PI5TSJeXqkzUJ8o/W1yk3faF/1iDa/
         NUv0SQF641jJaCvoK1bFL1rX8JRe1GjmhE8bRw4VgEeXydaSfUvIDsqXIK+b1nm3A/G2
         cru/eBSXtMO2ZkzFm6oAKjjN+2vb5zqAJkUMI+ifmXLvWD9xeKi8bD9ElA3DpAQEmlHG
         7MNGuKOvajEZavr3szTh6sszJ+DIpNbYhpH+8MzK7K7O7pVNxtElohfOuh26p2z3Rre+
         Find12oMFkDK6bgQzg4dMIrSnxbQm1JrghTV/Gopcb7tAzNCVxxuvMT0SZA4S/1twVEU
         0t2Q==
X-Gm-Message-State: AOJu0YxdmqwH74rxJ/XuL/jya0318LCqWMAH1nOtZxKFdH4HC5lRcks7
        zBDsMRLHEJ9wZzGS2vW2fyzDHv+dHQhRiDqnhUFWhQ==
X-Google-Smtp-Source: AGHT+IFug5Pn0iCtcHTxdYxtn/dxRL6m7q37tl1uS0fITM+sBu4ZDYI6ADuJFmJtHXSl++R49UIn01Vju8rKW4euhUs=
X-Received: by 2002:a2e:7308:0:b0:2b9:ee3e:2412 with SMTP id
 o8-20020a2e7308000000b002b9ee3e2412mr1914441ljc.22.1693400978045; Wed, 30 Aug
 2023 06:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230830110402.386898-1-joel@joelfernandes.org> <ZO86ik6QWamW2u/j@infradead.org>
In-Reply-To: <ZO86ik6QWamW2u/j@infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Aug 2023 09:09:27 -0400
Message-ID: <CAEXW_YTkejk872nJYTZ0HtMYLRswOjSPJyFz=HZjLKWUmy9GPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Christoph,

On Wed, Aug 30, 2023 at 8:48=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Aug 30, 2023 at 11:03:59AM +0000, Joel Fernandes (Google) wrote:
> > It is unsafe to dump vmalloc area information when trying to do so from
> > some contexts. Add a safer trylock version of the same function to do a
> > best-effort VMA finding and use it from vmalloc_dump_obj().
>
> Seems like 2/2 to actually use this is missing?

1/2 itself uses it.

And then 2/2 is here which does additional improvement courtesy of Zqiang:
https://lore.kernel.org/all/20230830110402.386898-2-joel@joelfernandes.org/

I used git send-email with cc-cmd set to get_maintainer.pl script.

thanks,

 - Joel
