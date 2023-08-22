Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C2EE49AB
	for <rcu@archiver.kernel.org>; Tue, 22 Aug 2023 23:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjHVX2u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjHVX2t (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Aug 2023 19:28:49 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD65E4D
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 16:28:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b962535808so80956151fa.0
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692746926; x=1693351726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBTDMDSo23gokNVaOPNo+G+rCKMIr9cjKbp1tVkr030=;
        b=vrPa6ss/LTBMPBuLHGl5EW4lkf3YO50040nHOoGM0mlSVKE1hA0WgumKFc0M9y2Hva
         xrkOY3UHXI0bPZ++gYRmXs+/v7mRf6GX2uR3B5F9JrCBb2PURkvMljBvKiQN4vdurFnK
         qEH+Uz7MJ0YhP0wDVcrO72e2mq2aDoRU34zE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692746926; x=1693351726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBTDMDSo23gokNVaOPNo+G+rCKMIr9cjKbp1tVkr030=;
        b=FWKHNGLKRH0N9A0dQHnNzdoMZEC/Hn6KOx3M4VYctOBpBMMRJNKNOMGgUgOdbou7Vr
         qUi3rC71ttb5qfwounWCdqovarMcZrP1qIykgfolNsG0xteX2mMfhUrh+EVO3QlIsBBQ
         moTEm+SPe3BbmnQaH8Av8p9ovvP+MNL2VV3SazEgAOqE/RN8jiRReadq45l06bBZ1Ky6
         lhnl27cusKt1DQB0q2mwfi7N9g9BhwbtsmgDfXuj3sc/co1BMMYRxrl3IzOqRNDtMEfI
         9TG0pVMvAymHLkibg5Wj7Lm7X75TRYmXQLe7BS2gbP99TrxzymHPM7ZbTRewC65EY7xK
         hEbA==
X-Gm-Message-State: AOJu0Yw5FpbzddohFckdg9s3uRJiGayncAqrBnk/Fsw6jiZ/PxTb8kgl
        sMwopLJscGbgAxDq/fu2yQbreHKs6mPyUKrO0WWZKi1b1XniRqUF
X-Google-Smtp-Source: AGHT+IFwaox5SAjB67Eu1fqVdQxJWRhbikUIvrEQfWaGP4JuXjYZ38iBQ8qh+5XpZufhD+8YiZGMJpw2zGUGFG0Ms8s=
X-Received: by 2002:a2e:851a:0:b0:2bc:d4ab:489e with SMTP id
 j26-20020a2e851a000000b002bcd4ab489emr1905912lji.11.1692746925631; Tue, 22
 Aug 2023 16:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230822200402.159177-1-willy@infradead.org>
In-Reply-To: <20230822200402.159177-1-willy@infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 22 Aug 2023 19:28:34 -0400
Message-ID: <CAEXW_YQ=-EqhuR-B8gqRzKxiwYNjayCwhNmE270OyXEaxDLhqQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Describe listRCU read-side guarantees
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 22, 2023 at 4:04=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> More explicitly state what is, and what is not guaranteed to those
> who iterate a list while protected by RCU.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/RCU/listRCU.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rs=
t
> index bdc4bcc5289f..aff1394f6d93 100644
> --- a/Documentation/RCU/listRCU.rst
> +++ b/Documentation/RCU/listRCU.rst
> @@ -8,6 +8,18 @@ One of the most common uses of RCU is protecting read-mo=
stly linked lists
>  that all of the required memory ordering is provided by the list macros.
>  This document describes several list-based RCU use cases.
>
> +When iterating a list while holding the rcu_read_lock(), writers may
> +modify the list.  The reader is guaranteed to see all of the elements
> +which were added to the list before they acquired the rcu_read_lock()
> +and are still on the list when they drop the rcu_read_unlock().
> +Elements which are added to, or removed from the list may or may not
> +be seen.  If the writer calls list_replace_rcu(), the reader may see
> +either the old element or the new element; they will not see both,
> +nor will they see neither.

Until here,
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

> +There is no equivalent of list_for_each_entry_reverse(); RCU lists
> +may only be walked forwards.
> +

Is there a need to mention that? If it changes in the future then the
docs go stale.

Thanks.
