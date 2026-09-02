Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289764A8417
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361355; cv=pass; b=qn/pq46tqPTBcRHQwrabqiXU9+MCt+XOJi7cmkOc9xahHMLPPLdc5lwmga1+rvo9vaKw53U118dm+Qtgka49cSAXwEGKPoJgQTdP6X7LAd2gnTSeOoTQ09FrNm3MF/S3HkYdRW9SlKXYDXagtL2iT+ipnFmB7VxhVAs58BQuGsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361355; c=relaxed/simple;
	bh=4hCdEHOD5c3EpnGTMHlUu8D7fgdaQakWWcnz0VXo2UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nf+D3gqEfugctt3+VwqUUhgZCCpp72tYsCdUVe2xih6IXHOR9YolDU72zc6lqM/hlSkxDnncDKV0c1nuAgNCKsjHcdeNBJr1kghJDRRlYkwqNv8YTg6bw2n7ws3qvuSSevmvlIyLTIsAk9A491VgpM56B8Tpup0ydI6Ctw9JkmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMHEYdga; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KebqNpno; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMHEYdga";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KebqNpno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788361346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=om4eZ/680TZMrxF1o7QRaN/1jT9e+TXfBTQEkyPNCmY=;
	b=FMHEYdgaCQBDpALaNskUyvogA8cNwPhTZI9ZiXmbDHDMUVCQ0Asd5YTKKVXbJf662vXotR
	yiLF9Pd1LgrWpfyFci8YUXugfX6n2AmHCUbbEKE0USDQmA0OKWeOiRjb4ujU85FoHcH5sq
	UYbll7afoN4w2HWB7Z4Mxitx2+eSdDk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-6CKT1P-UPuiwA3mYGEJaaQ-1; Wed, 02 Sep 2026 11:02:25 -0400
X-MC-Unique: 6CKT1P-UPuiwA3mYGEJaaQ-1
X-Mimecast-MFC-AGG-ID: 6CKT1P-UPuiwA3mYGEJaaQ_1788361344
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-39f1aa2b3d2so3761351fa.1
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 08:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788361344; cv=none;
        d=google.com; s=arc-20260327;
        b=WwwzphGmAk/Fo5AzpktYKS8w1cIZ5oCB4Q9NSWmIG2B6xbX112fhLnHiWLgmQ9SI3z
         M/WRK4Q0JsxD5h6IcCJIx3SCnb5Smm5NDcLCYaFcUmDwr6EO1qtg5B05Ns3lyRegSqyi
         rYB4Niy6nIzaUbQH92BRE3vRxVE1QeC9IInSd4QZS98FZBmqRJ8FNK8XuUiForJ9AfPC
         mHP0L6jCBWjiGec9Xu5CX0QlH4A/X9iICFtyRkQei4nbxBM7qE7k5oGZg5aSR29BhBXn
         Z/sXQzSU+ZQXAhAE0t9V4Wf1wghWzR7Mk9hyTeJsNni8jBqjdQTbfnYM9Z9cvxKCLGyo
         VtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=om4eZ/680TZMrxF1o7QRaN/1jT9e+TXfBTQEkyPNCmY=;
        fh=qNOvX4RcX68JBKrwWH4x5QCbmJSCoXZKuDrBNr2sMwQ=;
        b=e0uo6Xtbl52cDZ7N74ErgUK8TyjWAf52aMOs0BDROMRtmTS95z1EVcrZVYLgkp0Nn6
         Jm/E1ILSAlNFoQx7uh7o9LJc/pKsejXbD5gtv9d48WMMwBoCLERJHSlSM9lov4Ns9qFt
         e4U1986YU9LY6CO/0/taHE6nj7RxVOyckzCwgAslhT4C9CM77AwqxGGsOz/iVz2T6CHJ
         ssrokhHcB06wXSmpF7rnSm58rj6QVbmKBDP7OKiwsA52Ek+7uqDFYgr/AvSGYNf4geoZ
         EusCoXGtcLNC9Ge3RZbPPWC3RBAHkEPtLwl5LjRHQJBQl78l0fu6xqFqEkS60er1dVZB
         EdcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788361344; x=1788966144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=om4eZ/680TZMrxF1o7QRaN/1jT9e+TXfBTQEkyPNCmY=;
        b=KebqNpnoO9pYUMOmT8ol7BUJpxgP2/HePljmvJSq56/5H3B98nrJ7WTeZ91P8O4Pwk
         v/AL2zZzYefw0Kl2ShYiar4Y+ZfSL33zOVPE9i3rLNbUaRLn/QazG0jmvLzhTzUb4a9y
         TZiPvDQLsj8UA+YlsaBlZxOTv7QvL8S850jqe2HfTAxCMssuTW6u5m9stuu3Lu/aq97I
         H/OhI1sgoA7gajkVcCUssEzTuliRc7USJ7LG0S9AqwAZPuQui57sweOOuo9rr2yPzind
         HEUHVpW9vWBFu9HzDfLXbFkPkC3gjfOxr0rEwhiTB6tRuW4TrCpGy9lnOLzxmdIHmXRR
         836Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361344; x=1788966144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=om4eZ/680TZMrxF1o7QRaN/1jT9e+TXfBTQEkyPNCmY=;
        b=iJeXYq2yS0fxE0MR3J7LGzfWzNL5FjdHpDOSWeccezqLOWWLjgsb31ABMp4zT67tBk
         Myk8Zm/WLEYHv6kFgMWa7pG7wH7h7ygah+oNj3Scn+vlZ03IubwDtQBj0XaTuW7dCzE8
         rmVL6fy+QYaRcQNaOMxXbdU+8gvfXZO55vmvZXqW9IzIu93ZX/RWEX3UJ59aRQPeTtub
         q9Kdf0wb9PB6gDn9f55m+F/Zl1QSG+ea/Cs7AxhxZeERR6AU64mOyQ9D6CEW1ngjRbK9
         Uw6NletRxVRGOuJsEo7wiI4GCdbBdD/VZyAdl9qKB7Y7+9vFW0EQVZHzFKm8zBvBLNt9
         DMxA==
X-Forwarded-Encrypted: i=1; AKwUvBxKr2UYWrlGjs/4VULxY0MDqHsjmP53r8z6hMTlnrS2QyzftvUuxRnPOV/WrI10SGOZzvY=@vger.kernel.org
X-Gm-Message-State: AFuF++lRwqQElVaovRSgvUPHnZdF7iX+QpPOMa2TE45lLWGpku3MiG1L
	PrrYyay1ZtwnN7RmJcA01CldeGLuialwgXA1yDFxd9jjrriU7cBMwDFaCf3hFfQELTOO9y8wItR
	JxD7Ik3oSSb0GS1oqPKXsNoDOsK5QlUrLZJxA2eeyFES8yE8YjNmTIIRXyKMt1Ijsq3vF7Lwedx
	RVUZemTyYF8N41VBoA5izQt8vE/5o6
X-Gm-Gg: AYBFou3hcsV0PFL7HkI/64aX04jKn4IIEHMewE+lvpcBj3cc7DjfTa0VrYZF0gYOsRN
	k4InKK3bGOeajYiD/rAZvPebUh37zDE3WGvDYT5qgADX7vjOy5gix1a7u3or5XCqrYqhWf0KYMy
	uwZZwIy4YlzmsJbMQYyk2HGgehfzvpDqd9AzsHySLsU/JDiQvBhbmDaany
X-Received: by 2002:a2e:9a04:0:b0:396:7547:439e with SMTP id 38308e7fff4ca-3a34fd41f57mr13878451fa.7.1788361343822;
        Wed, 02 Sep 2026 08:02:23 -0700 (PDT)
X-Received: by 2002:a2e:9a04:0:b0:396:7547:439e with SMTP id
 38308e7fff4ca-3a34fd41f57mr13878321fa.7.1788361343420; Wed, 02 Sep 2026
 08:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev> <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev> <b686c4e5066aa11d7d868097b35e04db58190103@linux.dev>
 <CAK-6q+gET5NPczHYexcGXgptGTVnynYuVWzdbDkpsuvnbrymLA@mail.gmail.com> <2ff0e6ca8e1e05078a69dbd2b2ccd1e62fc4650f@linux.dev>
In-Reply-To: <2ff0e6ca8e1e05078a69dbd2b2ccd1e62fc4650f@linux.dev>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 11:02:12 -0400
X-Gm-Features: AcwNN1Uhwe44GL1WoqPHmRji7SmzGB5HOuEKMZek4F9ItyxN1HMNrCmnAfT5LSk
Message-ID: <CAK-6q+hfRsoznk9is9Z0XEkfhMjacw8urk7NkZ4cr=mw6HGwcg@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 2, 2026 at 10:49=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > Hi,
> >
> > On Wed, Sep 2, 2026 at 10:30 AM Zqiang <qiang.zhang@linux.dev> wrote:
> >
> > >
> > > >
> > >  > Hi,
> > >  >
> > >  > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrot=
e:
> > >  >
> > >  >
> > >  > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > >  > srcu protected connection and node hash tables and hand each
> > >  > element to call_srcu() for deferred freeing (connection_release()
> > >  > and midcomms_node_release()). call_srcu() is asynchronous: the
> > >  > callbacks are invoked only after an SRCU grace period, which may
> > >  > happen after the exit function has already returned.
> > >  >
> > >  > These exit functions are reached from exit_dlm() on module unload.
> > >  > Once they return, module teardown continues and the module text
> > >  > may be unloaded while call_srcu() callbacks are still pending. Whe=
n
> > >  > such a callback finally runs, it executes freed module code and
> > >  > touches the static SRCU domains that are being torn down, resultin=
g
> > >  > in a use-after-free.
> > >
> > >  I should rephrase it:
> > >
> > >  Due to missed call to the srcu_barrier(), when invoke cleanup_srcu_s=
truct()
> > >
> > Then there need to be a MUST call of srcu_barrier() before
> > cleanup_srcu_struct() every time.
>
> If there are some call_srcu() call, the srcu_barrier() should be called b=
efore cleanup_srcu_struct().
> usually, when the cleanup_srcu_struct() run, we should ensure that there =
are no pending SRCU callbacks
> or ongoing SRCU grace periods at this time.
>

For me, this is a MUST because who is maintaining something to know if
it was ever called?

> there are another reason:
>
> The midcomms_node_release() srcu callback can call call_rcu(), we must wa=
it the all
> call_rcu() to complete, because rcu_barrier() which in dlm_memory_exit() =
is required
> to successfully intercept these RCU callbacks.
>

Yes, I can see why "nodes_srcu" is necessary as this has something to
do with kmem_cache is being involed.

The "connections_srcu" is necessary for the above reason that the srcu
API requires you to call srcu_barrier() before cleanup_srcu_struct()
because for whatever reason we don't do that in cleanup_srcu_struct()
as I understand it now.

- Alex

