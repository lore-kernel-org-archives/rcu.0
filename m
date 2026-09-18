Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC84D9F67
	for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729136; cv=pass; b=BKpD0AB2kiRv8OL/VbtFnCBqXR127VF0PV5lLlymQ+yTPPLw7cnepumYs1Fq6JHldSiIdfo2MINJWkNcPcDXv9Ugi+jPmY6UC4RnsRIgkDZD23GFKfhxN/5K8xpBn9fl+mUpzP7q3GSzgBAddKEigMi4Od6dT+TBxSB55OgUwvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729136; c=relaxed/simple;
	bh=PU4xhmlWx858BmE7gAAS85VxJCPseREW97uqiUcKVyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzoKFXiv7O370oLkitrVHqv8qd69c/j6lQitY2nl0YminajhY7Q57XWhhbewkD4FD6VWKpDX60CW1WiVRKjatgycnGCRgP0hsVSOz9uavNo+r/nnbWnVEsCv9tjbBFncFr8JOfnAer3TfEHEclihTBJNina0+HMA3sOkzZCsb6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qg9uBU6W; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg9uBU6W"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a8038a9f10so798170a12.1
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 03:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789729133; cv=none;
        d=google.com; s=arc-20260327;
        b=d2TEOS90NZxG3l5luh0Z2vBulCCWKlUkoiI9f3g7dM+/G6fv20dSN6uqvXxyYwpCgu
         UUTzuA1ux5ntep37sJoM4AqCbRN1Aj8193SQa45ZfiLc+NuQ9h5SgjRokPXG9CzEt8NQ
         jT9m+JEzQgUf9Ai9GsJ7O7Ru2c9K2V8s11r1HjyuIeLRMFzvQH4tKmDFiDTAyjRksiSj
         kipvshrkMMdfAoaPXuQIbe1tp/2RRF0qPVuJ6fGGlokz1qp/mNKwmPb3jDqTMrfBI9UG
         2kZFuIuM2Fui3r2JVL/ijiCvJVH1I35JaHwXE8Gvbq+G3vr9e2vjS9KZrM80CGy8TYLG
         YCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMlA0tagVtBjA8CCzucBdpIo0a7MTz4RNAsPRQEaGLQ=;
        fh=2u2uSlRerU4c74QJrOK2xzPN5Ud56kHmuymBgEd6q1Q=;
        b=o7niJxK4YtGCnhQZ+GWEKoV+WqEMMDWCMsHV1iBXX3K3gAZZ+6DSSVbHjbtHfHcshP
         dwTDC44Adp+4UGwph1+rF5HsuIxA/aWjKhgno31LugfZZds3nVqSp9mUGPHMafQOzxbi
         OsRUX70oW4CswrVYV3XoakKaZD75LqdBba1eR7g6/kqaUFVJ2rtjMNFa3LnHxc+kVARv
         9W4e0C7niM+slRu/B5SDwyAJA+dnz8hgw9g+X7X6ElBStOICOhqUPW7//VF/VRe+99vZ
         NZyrNzaHQF3KdYLKnYUhbyThFSiCML9/P+wsKPHeOyoCOekGhURcWIyfyZK4IIZSwzl0
         GMuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789729133; x=1790333933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TMlA0tagVtBjA8CCzucBdpIo0a7MTz4RNAsPRQEaGLQ=;
        b=qg9uBU6Wbtt/PrcgcTz3vqvEsOLvMhziTScyWWiwCcA5pOLloCJ2fNDO6ZNrcVDLAl
         IsThsX0TApaEVuyzKvbSLLqMilhqC83YiuF82mS3GpjdB+RlNhFWZWcPpTTFN+JKyQtj
         ADoHc5GAQmqkBOSeAVoS2lvzr55HXljR3XiakLZVfwlbo9YQA4AhD7HNJSeMUFkDrLFH
         loGtB/FV0XiYupgEIgYuA4ViqTUI5ycGfyndulT3AxT9Vtaw97orDzYDwcMFEl8YT7ud
         DRJMc30zJRpPlG2ppQGaeYEPX0LO6eJAQNcR7sJesIvEZRtV3WFKqLY8Xk8HsgqjATIK
         g2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789729133; x=1790333933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMlA0tagVtBjA8CCzucBdpIo0a7MTz4RNAsPRQEaGLQ=;
        b=0VnA35AJ80iC5b4uIBQX2wpnw5L8XFEN57Po51MHW37hp6Q7ah0dfmxGbu5rsZOAS9
         njF3wxXTV6BawXlxy2qEP3rXAyclFRe0q8QUtbM3nrzm+Az8FT+BiaojqTKdqFtSR3rc
         PVOxSsLggBiwgbm4R8Tto7pfy1Z8gLD5r/8gsfgNbEPfRLIyeUjiEMqQtgSQmJTJq8SC
         5d7Iiq8+V15ZIgUMWxd7ivCkoippjJB4Ul8eI9/fq9woffpqVVsOCZg8dFH/mMxMHiui
         2ylHwmvk7mz4Bf1OjIfBFiCVHdZ5h9wY5t58hjhPikMZgoBDlYPSc0JA7t6CCsPO0hm7
         RG5A==
X-Forwarded-Encrypted: i=1; AKwUvBw9JSGVH+JTQ4cTpe2TeNRGNQEbSsTdEvEDJyqEbJkOsZkMjKDhyLdmrX4Itkbu4BsPcF4=@vger.kernel.org
X-Gm-Message-State: AFuF++lni79ZV23+6BogjV9UwW6tlZ65fvplZLiHtJ/s9/+kkYkKxxQY
	Aa8I3ILaOcVfqMNHQmMOa5Apo0HnB8erhkNMP/flGAZLvYdPgMApQGUA4mBBHHQkqCdVv5hzaNT
	OdnJqhhk3Bi9t4XierITJRhqsrwqyfaE=
X-Gm-Gg: AYBFou3+xZ3q2qnyAREDlhWDBDn/9/OqzcpN+1tLzwI4udtyX2gWqlecdi7dUc0kWFN
	xrTCOYtR7d19BWssPP7XJBiMLaHAV9rQoZHC7UHxjs9p+mIe4dxmQaT39/eW1AODkbxvTNh+/pt
	hrXcGOuilo7VezfUgPgo4GhZVBBYDPF9YG/NbykeqGo9e6SKF1nK7D2jF/X5ikYOu96BKntSIjm
	n5w6z0oWz0DUYaqul7qZwuaPNaNavDnq1M6egHKgdDJikBnEFJkiRZyHDkTHt+M24l+4QN0OUtw
	O1a0EqyoQfSyBG9pmzbJfFMmb8KDrUn496lJ4KImsOSaCDJ5CO6y8FbfgWuOUI3TIhqgXI4=
X-Received: by 2002:a05:6402:3044:b0:6a9:a137:9ab with SMTP id
 4fb4d7f45d1cf-6aa5637c07emr846362a12.20.1789729132429; Fri, 18 Sep 2026
 03:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915154248.3612028-1-puranjay@kernel.org> <20260915154248.3612028-2-puranjay@kernel.org>
 <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com>
In-Reply-To: <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 18 Sep 2026 11:58:40 +0100
X-Gm-Features: AcwNN1XZfTXkkKX_3JGi9RfSU461tgxxBg-bsGDiIbVR7bDjvuhObthNgEN_2_c
Message-ID: <CANk7y0gzipiJrObW0fbh0gP2DgKeZAUvCNuvaOdJrGWgE81LkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 7:41=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 9/15/26 4:42 PM, Puranjay Mohan wrote:
> > BPF programs that manage their own objects have no way to run their own
> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> > free, but returning an index to an allocator or unpinning a resource
> > once readers are done has no equivalent.  sched_ext's BPF library works
> > around this today by pushing freed nodes onto a list and having a
> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> > BPF program to reclaim them.
> >
> > Add:
> >
> >       int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> >                        int (*callback)(struct bpf_map *map, void *key,
> >                                        void *value));
> >
> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> > callback runs as callback(map, key, value) for the element it lives in
> > and needs no cookie.  A head can only be armed once, which bounds
> > outstanding work by the number of elements.
> >
> > struct bpf_rcu_head holds the callback state inline rather than a
> > pointer to it, as bpf_timer, bpf_wq and bpf_task_work do, because there
> > is nothing to cancel and so nothing that has to outlive the map value.
>
> I tried to fully embed structure back when implementing bpf_task_work,
> Alexei rejected that approach, because some of the structures (irq_work) =
I used
> are not in our control and might change. I think this applies here: `stru=
ct rcu_head rcu`.
>
> Link: https://lore.kernel.org/bpf/CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uNGZ3O=
BQh4V5Zt=3DWnQ@mail.gmail.com/

I agree with your analysis. Although struct rcu_head is unlikely to
change but still, I will change this to a heap allocated version where
we only keep a pointer and not the structure inline.

Thanks
