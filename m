Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD3C77B6E
	for <rcu@archiver.kernel.org>; Fri, 14 Apr 2023 01:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDNBQP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Apr 2023 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNBQO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Apr 2023 21:16:14 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B3630FE
        for <rcu@vger.kernel.org>; Thu, 13 Apr 2023 18:16:13 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id by8so1138185ybb.9
        for <rcu@vger.kernel.org>; Thu, 13 Apr 2023 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681434972; x=1684026972;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNHtFxDJlWhvI6wADsECZUb5iqPCc6WyyTDSQpHBCP4=;
        b=AGAi6TcUOpevNguQX5VZI/MKtP4++I+3zkSwEmzDDxo9XWXMyKlWljGtjFrMosS1ZO
         uZXXsmrdKYKfzjuq0gnJNKrjhb0bL2H08FOfpniz9xMFNPbB0Kz/VYjYRYAhzhD++4nX
         7nsMbZzLiTMhlpWhwuK0RE5X7x6rlS/J+nzxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681434972; x=1684026972;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNHtFxDJlWhvI6wADsECZUb5iqPCc6WyyTDSQpHBCP4=;
        b=UuhiHo5I42jbldkBU0iINGvn7Wy2mUVrLv88yONvaJe+XSl0qGE8COJOMMKYYKOkAm
         wch0RzmaJN1do456pEpEJqznl55wIRwR+gBz73hnc9Ggr3YusktY2QdXqvJiKCMdR7co
         4dq8U6vk/DMGMH2TFFxZW9iic7MrHU1nboL12ZOHKcuPoiXxDkj0vk7V0zHhhtto/t+M
         VwBLaUiRy/f5376i50fBxW3nDM9mGL/E6DMnfZgOSquLsJHECBzNbotDgqwlLy6IdweW
         /M5F+IvOQNQ5mVOk8AMOZUhTPp0co7g9At1EQRCH3QkW/A+VFHkzyyIHPtOFj+rALTur
         TUwA==
X-Gm-Message-State: AAQBX9dEXVn1TkCs2LbUK1kCo+ULVmqIsPW7KM26WUK6CpoKa/7Chdx5
        xuBBK8EPDp0yyFztO8gBVC8mKZ9mGqS3FIFVQVO0sf3KWTW+q1GmUgk=
X-Google-Smtp-Source: AKy350YBgqABe4fGYo+miNAK99kHZ/f3+4+DfdFNgd+lcx14l03CYmKrb+CqtAAvVzGRZZ5T2JuDG/+utkawrPli0/8=
X-Received: by 2002:a25:748b:0:b0:b8f:6ab7:9328 with SMTP id
 p133-20020a25748b000000b00b8f6ab79328mr977997ybc.2.1681434972610; Thu, 13 Apr
 2023 18:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com> <CAEXW_YRm62XHtpw4Ubp7x3n9jZJNGezRp0ymOGbQ3e62mysz1w@mail.gmail.com>
In-Reply-To: <CAEXW_YRm62XHtpw4Ubp7x3n9jZJNGezRp0ymOGbQ3e62mysz1w@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 13 Apr 2023 21:16:01 -0400
Message-ID: <CAEXW_YRPk6Q92MTL7Bnr9kzJT=FHTAiEwxLU=vT+VP+TqPApew@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     rcu@vger.kernel.org, ndesaulniers@google.com, nathan@kernel.org,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 13, 2023 at 9:11=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hello,
>
> One way to fix this could be to add this to the beginning of tree_nocb.h
>
> /* Make clangd understand tree_nocb.h */
> +#ifdef CLANGD_PARSER_ACTIVE
> +#define TREE_NOCB_H_CLANGD
> +#include "tree.c"
> +#endif
>
> And then at the end of tree.c, do this to prevent recursion:
> +#ifndef TREE_NOCB_H_CLANGD
>  #include "tree_nocb.h"
> -#include "tree_plugin.h"
> +#endif
> +#include "tree_plugin.h"
>
> Then in scripts/clang-tools/gen_compile_commands.py, we can just make
> it add "-DCLANGD_PARSER_ACTIVE" to all compile command entries in the
> JSON file.
>

Ah and even that will not fully work, because there is no entry for
tree_nocb.h in compile_commands.json to begin with :-(. However, that
also can be fixed. Here's how:

We can just add metadata to tree_nocb.h , something like:
/* clangd_infer_from: tree.c */

Then we make scripts/clang-tools/gen_compile_commands.py  duplicate
the compile command JSON entry for tree.c but for tree_nocb.h.

Lastly, we add -DDCLANGD_PARSER_ACTIVE to all entries (including the duplic=
ate).

 - Joel
