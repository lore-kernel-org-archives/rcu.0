Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33C219EB
	for <rcu@vger.kernel.org>; Wed, 27 Aug 2025 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253966; cv=none; b=TBAKDWWIwNGiPMe/gpyFuQyyaAMJSmt0oQmgJEJSXgHke3AmaVzO7BtsZ/m0UgCGC877+JB1l0TK6syzqCaScLdcocrSrXsnQ07IOHdx2Y6ozKjn0BXoMkm6HoRYVk5hFNS/K+Sgmqz1doAeVnbdlBupk3gx5c6f2C02EgDHNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253966; c=relaxed/simple;
	bh=Yx6UM87z90Ve7p+lWCl8R+FpbY+gFZTHVPHWZIEnMMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVmuQe7GuaSeg9Vyd2K6JiQ+QGoPMeN8XDKSRAzn35Pke58U5CGT++UjUT+lOhWArcQeddWaDEHS/lpb2xbffD0MfWgZtGFksPbk0/p/K6ObxQez+OBtVurcnDs9TqZpDN0CG1RAO0TQALwu2E9GhrcRdKRlPvv7IAwqjkbgT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZWxNZ0H; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZWxNZ0H"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b29b715106so80071cf.1
        for <rcu@vger.kernel.org>; Tue, 26 Aug 2025 17:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756253964; x=1756858764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE4j56bcgneni+baZfrodSksw7MRxk2x9FNKN/g2SD4=;
        b=WZWxNZ0H9wQUKC4I1JU/lrjvWyD1EKUw2Mj3JCUgSlbDKTeHOCjSkHdoUcMDq4w8fL
         4t6cCV52/4PB7z+SKA5uP9FJRf9QL9gqPUsarboFrWN4tGs4CP/oBRczypLwcJIwLUXM
         uaagt+ygVja9oFfY2NxH0DjrpZr9aQBJZ9+1Q/wAHHRnZMFN9JRQT3h//OzASE9P+m9a
         sU0Kk0JHrcD+Y/rsN0tdF4sij9evQhf3LsXIQsV/pvTgx+BJF1s3kVUuS4AnO9VrHz0k
         /ztWr/QO0gWq+XTwRc2uuyk4YZ2Sg1kCHDyuwwqiYa2WKWEBhSx/CRro6on/d9L87Yxp
         Ko0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253964; x=1756858764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE4j56bcgneni+baZfrodSksw7MRxk2x9FNKN/g2SD4=;
        b=rigFTVKZyVHhAE1BEXSga6qjFHE66K1y0PY6uAe2h1Hk1By7/QIKv3BWjdG7bfHZfA
         b8MG4Ui4sEpm4rHwohFsR+DyzMUAdkfoWZPTis3G9HafqHe+Z+L2A7tdDjiDOpfDDEhH
         TZqlk+d4QHL7X0vkticNSBSD/PRte+WBwtMmS1vDeaLVABox7Rl/1mpzqIqVC3Z7FX15
         SYkmQ2zi3zcw+X4bcIBlcv3rVXvMe2vKHKErqO4/nhj3X0pSUc86W9V98VY9XGq2NBbr
         qfdCwtK9VnglcvAUX/uxWHk8ZyQ94O+q4R0A8iVmpimGX1cp04vo7y8H0y58whUR0iXv
         5k2A==
X-Forwarded-Encrypted: i=1; AJvYcCXTPTpFfBcQtysadiORj0Tuq7y5j5Wv/ENQo5xKzeBGbbbA0VuvGc38E6t0FMX8zqkkXg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDyZb5qQ7YJWkuihgV7LqO1emHbtPEfRv6tpUr56HXTQwktgoX
	xsuEj6gG1CsSEWQxYE37uc95SS0Dz7mdVaQR34eD6+I9FAUZWVksnPcs5NZh3Ta6r9vE5BkrdP+
	AepcMU6cO8D5a4DnGx7Serr9KqyWoAt1zDyJkVwMH
X-Gm-Gg: ASbGnctRyCW1KrB3MZZenvUPFc6ZzCZ63GRGpCDs5/PI8cAmvbqluP3Cta41ku/K1xA
	8/WVnTl2TPAksaL0VPMPBxKFAeVYhnihnCpIbOjzNZGSvKkY6XtNVm1shUlwfJeYsFswqfTP4Ap
	3qqE+azypvY4HE4zH/MGJ3ewIHR5q0zc2SPP5BIlcU4tHaLrwKG6aP1XXNWUzA9HeZaMWYYKrEH
	9C1b8A8EwfEirYRFr4KJl4=
X-Google-Smtp-Source: AGHT+IHKzkOVA97IoeFOhKzhjh88sPk1YwIXvTlOSZoPINFWeat9lSKrAMubEHDbEHy9C13HrZIHNUop3Q+tYrmsAvA=
X-Received: by 2002:ac8:5a42:0:b0:4b2:939c:9c1a with SMTP id
 d75a77b69052e-4b2e2c4f835mr7873931cf.13.1756253963326; Tue, 26 Aug 2025
 17:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-5-b792cd830f5d@suse.cz> <CAJuCfpHR=hceuAcnaCr3Hg-3mknvsmYy7jSScA8SATn7iwoN_w@mail.gmail.com>
 <711d539d-da4b-4f77-9be6-ca11b6fa5162@suse.cz>
In-Reply-To: <711d539d-da4b-4f77-9be6-ca11b6fa5162@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Aug 2025 17:19:11 -0700
X-Gm-Features: Ac12FXzxRQWqZVSs96sDjlJgMo-UL6e05LwJ4TtNEU1hDljVd05nsUaqKjsm23A
Message-ID: <CAJuCfpFC6XELVof1xbJ2rZoxX3rHQfd34Du3=N_UeinM2DzPVA@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] tools: Add testing support for changes to rcu
 and slab for sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:32=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 8/22/25 18:28, Suren Baghdasaryan wrote:
> >> diff --git a/tools/testing/shared/linux/rcupdate.h b/tools/testing/sha=
red/linux/rcupdate.h
> >> index fed468fb0c78db6f33fb1900c7110ab5f3c19c65..c95e2f0bbd93798e544d7d=
34e0823ed68414f924 100644
> >> --- a/tools/testing/shared/linux/rcupdate.h
> >> +++ b/tools/testing/shared/linux/rcupdate.h
> >> @@ -9,4 +9,26 @@
> >>  #define rcu_dereference_check(p, cond) rcu_dereference(p)
> >>  #define RCU_INIT_POINTER(p, v) do { (p) =3D (v); } while (0)
> >>
> >> +void kmem_cache_free_active(void *objp);
> >> +static unsigned long kfree_cb_offset =3D 0;
> >> +
> >> +static inline void kfree_rcu_cb(struct rcu_head *head)
> >> +{
> >> +       void *objp =3D (void *) ((unsigned long)head - kfree_cb_offset=
);
> >> +
> >> +       kmem_cache_free_active(objp);
> >> +}
> >> +
> >> +#ifndef offsetof
> >> +#define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
> >> +#endif
> >> +
> >
> > We need a comment here that concurrent kfree_rcu() calls are not
> > supported because they would override each other's kfree_cb_offset.
>
> I think it's a bit more complex and related to the commit log sentence "T=
his
> only works with one kmem_cache, and only the first one used.". The first
> call to kfree_rcu sets kfree_cb_offset (but what if the rhv offset is
> actually 0?) so the others won't update it. So concurrent calls will work=
 as
> far as from the same cache thus same offset. But I'd like Liam's
> confirmation and the comment text, if possible :)
>
> > Kinda obvious but I think unusual limitations should be explicitly
> > called out.
> >
> >> +#define kfree_rcu(ptr, rhv)                                          =
  \
> >> +do {                                                                 =
  \
> >> +       if (!kfree_cb_offset)                                         =
  \
> >> +               kfree_cb_offset =3D offsetof(typeof(*(ptr)), rhv);    =
    \
> >> +                                                                     =
  \
> >> +       call_rcu(&ptr->rhv, kfree_rcu_cb);                            =
  \
> >> +} while (0)
> >
> > Any specific reason kfree_rcu() is a macro and not a static inline func=
tion?
>
> Think it's needed for the typeof() to work. The kernel's kfree_rcu() is
> similar in this aspect.

Ah, got it. Thanks!

>
> >> +
> >>  #endif
> >>
> >> --
> >> 2.50.1
> >>
>
