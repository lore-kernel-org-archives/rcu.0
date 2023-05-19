Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F69BC7EE29
	for <rcu@archiver.kernel.org>; Fri, 19 May 2023 18:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjESSxE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 May 2023 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjESSxE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 May 2023 14:53:04 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D596E43
        for <rcu@vger.kernel.org>; Fri, 19 May 2023 11:53:02 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-561bcd35117so46304627b3.3
        for <rcu@vger.kernel.org>; Fri, 19 May 2023 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684522381; x=1687114381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvuKY+QiDOSLvpXbndNJuNB4TnmV65tz5O+BwirwJsE=;
        b=cQEFC8tuad0qBhxqpwtvv0nLTlTibMvPJDQnyjusclVn14+QH4ihHQrIqRw2DEz+JK
         BJ0+YvvKq+psiSFOyfBxFnwWmf1LpJdJMSyEogWaGJEbHIiyCUspbIhPjVEe26EUEFeq
         ozsT9vTGWhambTmSQsW53Rg+POo8Tp4eyXBOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684522381; x=1687114381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvuKY+QiDOSLvpXbndNJuNB4TnmV65tz5O+BwirwJsE=;
        b=Qos1SZnX5bQWbLWTRiavhxJrT2bwN8CHdo2mg8OOzXduKqe9DONy7c0NbOIr2bf80q
         +NRXfu4vbVWs9WTyKmoDEnwVdJhTY+Uq1rvGMowLjlUvE3PYdO8H0OBz0YDlRQbB+UeI
         8zIj9ePFHqNBGMSVHtehqUPJQfglduLaukJLkLSIw4qU/YzSio8cQz0sx43i2RhCrWeh
         bAclNLeTsYlkdkVOCyeLVug13rkGinFV8AH2jGBglatA1aUTP/sZBBOaNGyXOX8hUZbc
         eH/m+z7RTG9JJ3HwFRkADOFmrd6ESmmDKnaRJhlJK0KwGQzV1KmTDjVo17wHVvv+z9Ru
         Zx1A==
X-Gm-Message-State: AC+VfDw0SZlob8CEZzVKxpDgHIqhQCcK2EBbeai8s5MGYEvkEW8+FzcW
        xFoYrW6ZWgiD002RMx+7B/KWqh42wMjOefvkFxRKAJKDV30nA7jfZ80=
X-Google-Smtp-Source: ACHHUZ52j3pJFuWwa8N8k1bNDWUmJfHV19FIYtf6A4VcQe3nEXJuM97t5ReUFUuGS1iExkCOEK1Q0+8kfZ/fHjlGj2I=
X-Received: by 2002:a0d:d44f:0:b0:55d:aff9:975b with SMTP id
 w76-20020a0dd44f000000b0055daff9975bmr3126455ywd.12.1684522381325; Fri, 19
 May 2023 11:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230518224008.2468-1-sj@kernel.org> <20230518224008.2468-5-sj@kernel.org>
In-Reply-To: <20230518224008.2468-5-sj@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 May 2023 14:52:50 -0400
Message-ID: <CAEXW_YQFqW2QcAuHZEhc_GaUaB-=QOS0WgUOizd=FYwtFQ8vag@mail.gmail.com>
Subject: Re: [PATCH 4/4] Docs/RCU/rculist_nulls: Drop unnecessary '_release'
 in insert function
To:     SeongJae Park <sj@kernel.org>
Cc:     paulmck@kernel.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 18, 2023 at 6:40=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> The document says we can avoid extra smp_rmb() in lockless_lookup() and
> extra _release() in insert function when hlist_nulls is used.  However,
> the example code snippet for the insert function is still using the
> extra _release().  Drop it.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/RCU/rculist_nulls.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rcul=
ist_nulls.rst
> index 5cd6f3f8810f..463270273d89 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -191,7 +191,7 @@ scan the list again without harm.
>    obj =3D kmem_cache_alloc(cachep);
>    lock_chain(); // typically a spin_lock()
>    obj->key =3D key;
> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> +  atomic_set(&obj->refcnt, 1);
>    /*
>     * insert obj in RCU way (readers might be traversing chain)
>     */

If write to ->refcnt of 1 is reordered with setting of ->key, what
prevents the 'lookup algorithm' from doing a key match (obj->key =3D=3D
key) before the refcount has been initialized?

Are we sure the reordering mentioned in the document is the same as
the reordering prevented by the atomic_set_release()?

For the other 3 patches, feel free to add:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
