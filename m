Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB48C83F23
	for <rcu@archiver.kernel.org>; Wed, 30 Aug 2023 18:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbjH3SsB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244038AbjH3MRf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Aug 2023 08:17:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A711BB
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 05:17:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so84289461fa.1
        for <rcu@vger.kernel.org>; Wed, 30 Aug 2023 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693397850; x=1694002650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D8Njhns0o4ZXlGI4JVLpfsWYsYkQtkNq/+nuGr1lhk=;
        b=sPUBDGG+Wu6dU49eF5DfJhUY+bvvTY88SzbQpheSYYWdNaNqb5cDcGnhi+1uyXNa6+
         QkUmtmZ9+vYlM86YvhfsDfU5Ld5+Bk6I6etE3Pc280NGQSLpiI9JUTOq9DTTjR0e8q52
         ta3tsbNo4XvI5PIe35A2ypw6Lv+ysjgxf4uS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693397850; x=1694002650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D8Njhns0o4ZXlGI4JVLpfsWYsYkQtkNq/+nuGr1lhk=;
        b=fc0ZwDUBUBjH0zaJojxlFJp+2FdnJlhD8O0IQ4p/Nq9sP1LANbrNjpCjXmVFuf+lTy
         WmUZtivpAOM1NDjuGLuotLQSuiJlmoUL4XKecxAhyPc+w5vQmPBTEZHs/3h+/t1S0XL4
         Be3bgFXrhFhTywYJu5zRVy/xYg/8vGytValqYm8Bui24c8i5eqob3sCqnbVnx6jktJ/d
         r14yn38E5qoORKkn/ytssp+r/w9KIiH6h8LNutAmvI5GcsqByjYyJ3cZ0wz9l8EyNuYZ
         Mz4i/Z0iVabJrjokZ3/u6oozP5D97ro+WefJ87so7UlqwxjmvrJ32Xqd+SQUsvOtzMXC
         JdnA==
X-Gm-Message-State: AOJu0YyAth6YJofB7XdzduWVR4zdgomP6RVFIAgcrPqjYupMpkquWdr2
        s2gzPqJ3+HAfL8rRGyQr3JbjroK7NtfhxK2Na25e7Q==
X-Google-Smtp-Source: AGHT+IHU5zsWZXoLfZWVx357d+myi6P73wk6EBsN8w4djwvSLtWEVOLMa6fA+veIiDvfTjCmxYlKRVMpX2aZ9hvMH0o=
X-Received: by 2002:a2e:9796:0:b0:2bc:f40b:574c with SMTP id
 y22-20020a2e9796000000b002bcf40b574cmr1814357lji.42.1693397849451; Wed, 30
 Aug 2023 05:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230830110402.386898-1-joel@joelfernandes.org> <ZO8xHT5HUDTSVUai@casper.infradead.org>
In-Reply-To: <ZO8xHT5HUDTSVUai@casper.infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Aug 2023 08:17:18 -0400
Message-ID: <CAEXW_YRvCQP+eoWmbnEwXs925xXQYPDuCp+iyzWeo8HY9dq+Ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 30, 2023 at 8:08=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Aug 30, 2023 at 11:03:59AM +0000, Joel Fernandes (Google) wrote:
> > It is unsafe to dump vmalloc area information when trying to do so from
> > some contexts. Add a safer trylock version of the same function to do a
> > best-effort VMA finding and use it from vmalloc_dump_obj().
> >
> > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: rcu@vger.kernel.org
> > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!

> I once started writing something similar, but got distracted and the
> immediate problem got solved a different way.
>
> It does make me wonder if we couldn't make this tree RCU-safe, but
> that's obviously a much larger job.

Yes, that would be nice.

 - Joel
