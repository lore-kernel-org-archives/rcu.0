Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935784A0F10
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359815; cv=pass; b=ar9mA0Lb+24cZ7vTzaL7CCIOlKpbHMH9EftQtv41y3AFXhLiy7XQNf47HOjPiBGo4govw6qsa7pb4KufWf6+Xi8BJObjbh7d9oon1hOjVSsvzA8NnNDbo3y0DIg0LCYv2eVkyWO27cdGMRod64CtObKb3JouClPm9olEiMJZGXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359815; c=relaxed/simple;
	bh=TZmvaasfuNqPTtuT70sqqQUSwx1v/e/Zx2LqnB4yVi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fpu9ztD7rWb15Jpjt8u2+2EB2uWynCL2ZgmM9M4WWRX2Ar85idhEzm493uoA9iCxm2YO6zh7wHRc9OGFlF5iYxPeHGGYC6ffbXWLzT6WOxX+tsAbVpGvUhtg1WpB0WV9pWX/uDyZ6w3WDhek6VVal05DxaKuFnBu4Q9fggxztW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX1eR1A6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDSRiaUj; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX1eR1A6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDSRiaUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788359812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVfiEtRpqIOnrFF+s2huQjsZo4q2rNenXW836wUs2sI=;
	b=eX1eR1A6ZCuqt1byTeplHoQFpC7VUv7XiZtcKnlQzISYYOlqGdaYZtHRR3mmoPSuokgCMu
	+4M7rNlmFGGwVP5G7k7BQqi6cn9cLEN545Ce2/cIurgJikwFCXP9cPP3NuVpLhc2dgqgY/
	lPJH2PzEifUOChF7qPLsFOhrfXJQuIk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-jgpzQDIBNuak2NJYhprZlA-1; Wed, 02 Sep 2026 10:36:50 -0400
X-MC-Unique: jgpzQDIBNuak2NJYhprZlA-1
X-Mimecast-MFC-AGG-ID: jgpzQDIBNuak2NJYhprZlA_1788359808
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5b5f157bab5so633130e87.1
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 07:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788359808; cv=none;
        d=google.com; s=arc-20260327;
        b=LkfsU0yefbvPVsvcZIi9tkzGmPvf5fKUY50s8Vj0bglH/P17vhgKbwB2GE7dUFfSLI
         PqlRMTYFY7d5MRGWGztBaub7PbacoXZkZqhHJRutLLLdo5NZxWY1lFAWiG5oevM7UKdd
         Uxa2Kcgf1MIkikFdm5F8C63Vl8xdwk89Iq0PQyK84l7DqD0KweHXLB4YAfsFnENwFZRa
         cUa/YoSCQXeAlgyLAk8j+NdBNalqjua//AuFm2OlR2gNxtV4/eVxflE8pDCCqA17nUKg
         bzqwV6Y55f9rlBOgfJBnG32dgTkRHRGMw9+cHiCu9ErEb6db2YOSw3/yQ4RL0aqCyddJ
         lPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WVfiEtRpqIOnrFF+s2huQjsZo4q2rNenXW836wUs2sI=;
        fh=bOHIcSD9ykpIpAfAMeV3D8dzkILyIiUtBuos6hTkGoo=;
        b=oxK8QBmfLMzWWI+Ygcy6AKlZtKai93djdh9N+q1DrTx413+Qa2uI/a3vM5E9jQ6kGW
         KWEY1dGrm8MqoAyq+vcYk9TIbVMaMO4zVGmW+n1+Zf3n+y9CwicuapdsP/RdXvfaNkC/
         E/GNF6yXRtZ3YDwrLa0T23o/j9Ka+Bg/HD9ce6QiGPjyzCmqkojrZn+Lh2eHVK6YZTIe
         UIiHpIXav94/GnNxmNuFwuIAHTd9DtVYGQmqIl/PriWTG8c5Fbmx3FufxBNDvAt6ayeK
         5wvSW/tjwyAhfAwnMDFadi5AaLATMyP6FXmR/uxal1MBSmq5qSiVu+sqHTMD1dFcQSBb
         Xwwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788359808; x=1788964608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WVfiEtRpqIOnrFF+s2huQjsZo4q2rNenXW836wUs2sI=;
        b=TDSRiaUjaoctffjIAcH3xwPkR6Xs3p+mdi/sr8c7sJuuLWPWXk1uGk0t/G19w+hP3C
         L1jwpr535LQih7oMmPs5RXKRwTMC3HSUYTFl0RIN2KjKa4y+qi1OzwYW7nJtlGLfI4qh
         K/kQF2BlnA20JqcmQNgyjbo8JOpkUgNrkm++4SRLysssr8FHfm0wGdNVbMhzJe7ElMFz
         Bsfd6KidZ/t5XMfUoR4rEuykDMS57L+iodic/ANtTymOS/xTDdR9wun05UjUbp0QlV11
         WK3HE4+u23Val5tGnkY7BW2iBdGwo9H+kBVXDu/rNFttkyDlAlk0llm+fggQNx22Y4Iv
         82nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359808; x=1788964608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WVfiEtRpqIOnrFF+s2huQjsZo4q2rNenXW836wUs2sI=;
        b=G1zQUOzdA1zEgfB8ApC7mYFjc4UYtd6cbkZYFPrAxrHVuU5EpXtn89WD1f3x0oB+1i
         XjYDuZuyqcbNLtGKMX2sgbUsDylNDkeW3RsNjU4lxJMi34SS82w29OsWIKlSpDTWhQ3+
         DqYKmT4GAw1OfHuRQLqY/RawqEzRQZZKD2iBYVDTne+BSIwzDBjcHjPlCD6z8A2fvzkJ
         Mc4PAkzO0kIKy5QgQUa+U/phcBo+tECOV/bhwP/aB9nvVMRAZ/3LOtA/CfzoW0yTCNY1
         RfIXRhV1jtPtpj83mgcYgn4m02pXNrWyD/MExIlJY9qcxl6kpGURKxwUKuUUm3kUybkG
         ED6g==
X-Forwarded-Encrypted: i=1; AKwUvBxWnpVMJvM0te8/l0roihEYUVGsWAdOjwQnut9y1x8fAHRuf1cLQjOihgYcPWtNcM4mFvI=@vger.kernel.org
X-Gm-Message-State: AFuF++m0CFH6raWu2E+dRO7tpL/7GFzZfJYTxlPb+oKCg0Gqgi04joUi
	MUOSOBJfVGZ5xOvB9qHK+cdKPCGulMcRfXkM+gsBVrvzsuAtxsUfqhR7CClBUrLES2yi7Wls6TL
	8YxP4o9E0BG2BxuyeGLrnfEiXrXJBPpx5G06+5dr50k0RdHoq86n2CdBWiMV/OctnRmzrEAN0zF
	2hUG5wrH58LD9JTTj5+MwgW999b4r4
X-Gm-Gg: AYBFou2Ht97jCrb8r2i6xa57+LHKh2aU+F8eMDzjdgfJwXTq18F7dLY27HALqeHJTd6
	ZVJmaAySpsTI8/1EzFwXuge+eXmo6PmjJ2ePKWYW9pm596pgShpkwBcCp2xtr28zOfHdVAbJfLk
	+O6lvbkVhPmPqEZwL3OJIF6Y4PUnIKvKeFnUQAu91PPznxwWs4nvhIlSkr
X-Received: by 2002:a05:6512:39c6:b0:5b2:a919:f9fb with SMTP id 2adb3069b0e04-5b608699880mr1867194e87.22.1788359808448;
        Wed, 02 Sep 2026 07:36:48 -0700 (PDT)
X-Received: by 2002:a05:6512:39c6:b0:5b2:a919:f9fb with SMTP id
 2adb3069b0e04-5b608699880mr1867179e87.22.1788359808018; Wed, 02 Sep 2026
 07:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev> <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev> <b686c4e5066aa11d7d868097b35e04db58190103@linux.dev>
In-Reply-To: <b686c4e5066aa11d7d868097b35e04db58190103@linux.dev>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 10:36:36 -0400
X-Gm-Features: AcwNN1UVK4Wd1puy8en3G-MOknq5D1y938UAw3x7G2DdWgDZO_ERjPjfOaq8jX0
Message-ID: <CAK-6q+gET5NPczHYexcGXgptGTVnynYuVWzdbDkpsuvnbrymLA@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 2, 2026 at 10:30=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > >
> > > Hi,
> > >
> > >  On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
> > >
> > >
> > >  The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > >  srcu protected connection and node hash tables and hand each
> > >  element to call_srcu() for deferred freeing (connection_release()
> > >  and midcomms_node_release()). call_srcu() is asynchronous: the
> > >  callbacks are invoked only after an SRCU grace period, which may
> > >  happen after the exit function has already returned.
> > >
> > >  These exit functions are reached from exit_dlm() on module unload.
> > >  Once they return, module teardown continues and the module text
> > >  may be unloaded while call_srcu() callbacks are still pending. When
> > >  such a callback finally runs, it executes freed module code and
> > >  touches the static SRCU domains that are being torn down, resulting
> > >  in a use-after-free.
>
>      I should rephrase it:
>
>      Due to missed call to the srcu_barrier(), when invoke cleanup_srcu_s=
truct()

Then there need to be a MUST call of srcu_barrier() before
cleanup_srcu_struct() every time.

I am confused here.

- Alex

