Return-Path: <SRS0=/cn9=WN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B95C3A59B
	for <rcu@archiver.kernel.org>; Sat, 17 Aug 2019 04:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398942173B
	for <rcu@archiver.kernel.org>; Sat, 17 Aug 2019 04:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X4lTv/Yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfHQEi4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:38:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33914 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHQEi4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Aug 2019 00:38:56 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so10391737ioa.1
        for <rcu@vger.kernel.org>; Fri, 16 Aug 2019 21:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GtQCwZ2X3Dci9EQCWwa185nLCtMLhK/fJw/6g7BdD+w=;
        b=X4lTv/YqVm9nOz9kEUBgZsT4AKBufywPYgaDkRVxEoudsf1f+4NUMArTksa2fqaxvf
         gk5ymABGfU2wu69753L7SvTw1ffiZ9CQrQZZ6OvB6FT/El3qGVUjqgQhmEt6qU5Ow/lI
         2ykxgHOiN2tvVYnvxUdP0+wUrxBXoRT+4/OyT0VsxsKz7IPiF8U5Xy1dAHKPV5gtH10n
         pqljDzRCGrAga9Tda150byVBoamxRAz4GYwTD1YF7JhCW6VugRPm+YBLnEF5hWEd9yJO
         aELgJdCNJjimfJBJoqXpTfRNGrX91gBe0UCv05t5PpDjUeo07NvXqqFtHHxJcIbCVT14
         QvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GtQCwZ2X3Dci9EQCWwa185nLCtMLhK/fJw/6g7BdD+w=;
        b=CJKPwtiaY/K56YVhkr77riy8o+jArS1DchtxR4o/2LaVsJOAV2Jsu70HvbxK8Awd//
         HL9jVBQT8dWgjkMYrbwSPTof57eAfdLDo7SjWyqdWA0Awg60qJZN9SMCdrYNWcNbdo/f
         U65+FyAWgVTgjxN4kJaxtqWvSzNKL4mMJTMAnjw52AVitWE0pCS7n91VO94X/lNUFy1M
         vbnrc/uq8zVfDKusfvtyHvXA8pdQ98intwdqNSuAm/V3k2QWp6Tycukhb3Xe2YR1EO3R
         BdaW75JORPvLjj+/LuOhNbkq2ZDdtBOiSjxufnFW4/BaITV+StrYbzkfzYI3Utbdjv/l
         WQew==
X-Gm-Message-State: APjAAAVrDTqjhq6TpyHbrjt99zKbGEZegNMeGDFVGXLw/dfYV44OY2H4
        KsuwW/3svC0sbUK2h80dCbHnBQ==
X-Google-Smtp-Source: APXvYqyemrGz5/yyrhPBXlViihIGtYKX2Y4D4mb8FE5EQ/KLgkxbJNTFXm1Afkdt0tLEFLrOMKEoAQ==
X-Received: by 2002:a5e:990a:: with SMTP id t10mr14098316ioj.182.1566016735927;
        Fri, 16 Aug 2019 21:38:55 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id s4sm14278009iop.25.2019.08.16.21.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 21:38:55 -0700 (PDT)
Date:   Fri, 16 Aug 2019 21:38:54 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -rcu/dev] Please squash: fixup! rcu/tree: Add basic
 support for kfree_rcu() batching
In-Reply-To: <20190817042211.137149-1-joel@joelfernandes.org>
Message-ID: <alpine.DEB.2.21.9999.1908162131490.18249@viisi.sifive.com>
References: <20190817042211.137149-1-joel@joelfernandes.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, 17 Aug 2019, Joel Fernandes (Google) wrote:

> xchg() on a bool is causing issues on riscv and arm32.

Indeed, it seems best not to use xchg() on any type that's not 32 bits 
long or that's not the CPU's native word size.  Probably we should update 
the documentation.

> Please squash this into the -rcu dev branch to resolve the issue.
> 
> Please squash this fix.
> 
> Fixes: -rcu dev commit 3cbd3aa7d9c7bdf ("rcu/tree: Add basic support for kfree_rcu() batching")
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.9999.1908161931110.32497@viisi.sifive.com/T/#me9956f66cb611b95d26ae92700e1d901f46e8c59
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
