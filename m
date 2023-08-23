Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC8FEE4993
	for <rcu@archiver.kernel.org>; Wed, 23 Aug 2023 13:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjHWNZD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Aug 2023 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjHWNZC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Aug 2023 09:25:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF310D3
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 06:24:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so87134881fa.1
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692797072; x=1693401872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyeJbpTjCP51MQnxGSax8gdzG39/ZHWBRlZKU26asFY=;
        b=CRGKl8uEUOIhJJIcxp8esgUsnSGf58E+m+KNBXk84DVJImcFQzbbl/8FH46m9paeVz
         3jnEbgQhgLNxiYAH2z6FtbYrvI8bhaz5pUZNS+jRDb/YspxGhcfM33jWTkTBsXaBT/Oj
         z2pepbx10nbecgQ8C8u0LY/wpB9bRrVf6sG/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797072; x=1693401872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyeJbpTjCP51MQnxGSax8gdzG39/ZHWBRlZKU26asFY=;
        b=USYbORaKI7aRFeFN/H2LhDxYqnZDBCtZnLx4ZzsEI4IBa87YFuSORXqz18GMVMu6CU
         Bp41CaXslhS+wwWt5QEo902aGh+25nwxm4lS6mgT/Dt0ujMCb/EdQcu8YckkHU9bYlz7
         EsJimeuV15MlDTvzlDJxv15OJXFg8a/n81aKQVDvHTYbYtp9kZ2U2Erg4sgNG79bmguZ
         tcyNRmfV9wAvS59UJNnaA9TZzi6wreZTWDGQ9BQxen82RKGdaIRRpTw7Zi8aUThd8MU5
         TlXa9FN1TkANuWc7AZ3w4xcBE9bPEEzBgq9gPfDwkpIiHgOBljOLAVLp/YGhkv1BFt+X
         SNog==
X-Gm-Message-State: AOJu0YyF0S2YgiiPb+SMpmsaG6nvIjQpwCUeqmcnCRpXmyWEXScBkStA
        wY5Pyj5RnzGXdWauuHNRfc7enwpQtQN2h5KITgmYGw==
X-Google-Smtp-Source: AGHT+IG332pbJlkZF8owkTLk4LNUINp7+6G4iWlIY5/SWfMbmf7394gP7qDkWTk8ki8UWvEjF/4f+h62tg0hEr9THWQ=
X-Received: by 2002:a2e:7817:0:b0:2bc:da3e:3bd2 with SMTP id
 t23-20020a2e7817000000b002bcda3e3bd2mr2067283ljc.29.1692797072024; Wed, 23
 Aug 2023 06:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230822200402.159177-1-willy@infradead.org> <CAEXW_YQ=-EqhuR-B8gqRzKxiwYNjayCwhNmE270OyXEaxDLhqQ@mail.gmail.com>
 <ZOVKmIDCcHGT8haM@casper.infradead.org>
In-Reply-To: <ZOVKmIDCcHGT8haM@casper.infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 23 Aug 2023 09:24:21 -0400
Message-ID: <CAEXW_YRcEE5v+6=NWUE8aEVQA+m0aXvjVNtRNc5U28gHxDSTAA@mail.gmail.com>
Subject: Re: [PATCH] rcu: Describe listRCU read-side guarantees
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 22, 2023 at 7:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Aug 22, 2023 at 07:28:34PM -0400, Joel Fernandes wrote:
> > On Tue, Aug 22, 2023 at 4:04=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > More explicitly state what is, and what is not guaranteed to those
> > > who iterate a list while protected by RCU.
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  Documentation/RCU/listRCU.rst | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRC=
U.rst
> > > index bdc4bcc5289f..aff1394f6d93 100644
> > > --- a/Documentation/RCU/listRCU.rst
> > > +++ b/Documentation/RCU/listRCU.rst
> > > @@ -8,6 +8,18 @@ One of the most common uses of RCU is protecting rea=
d-mostly linked lists
> > >  that all of the required memory ordering is provided by the list mac=
ros.
> > >  This document describes several list-based RCU use cases.
> > >
> > > +When iterating a list while holding the rcu_read_lock(), writers may
> > > +modify the list.  The reader is guaranteed to see all of the element=
s
> > > +which were added to the list before they acquired the rcu_read_lock(=
)
> > > +and are still on the list when they drop the rcu_read_unlock().
> > > +Elements which are added to, or removed from the list may or may not
> > > +be seen.  If the writer calls list_replace_rcu(), the reader may see
> > > +either the old element or the new element; they will not see both,
> > > +nor will they see neither.
> >
> > Until here,
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > > +There is no equivalent of list_for_each_entry_reverse(); RCU lists
> > > +may only be walked forwards.
> > > +
> >
> > Is there a need to mention that? If it changes in the future then the
> > docs go stale.
>
> I don't know if there's a need to mention it.  It was something I noticed
> while reviewing the code that I didn't see documented anywhere.
>
> I don't really care; happy to send a v2 without it, or you can just
> apply the first paragraph.

That sounds good to me, Paul do you want to apply it with my Review
tag and without the last para?

thanks,

 - Joel
