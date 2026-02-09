Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468238A70F
	for <rcu@vger.kernel.org>; Mon,  9 Feb 2026 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662711; cv=pass; b=J7vSmSZcYdxVAmdvFOtbMQD5FAaTv/frHsl21hb9DX6V2Z7vieBnm6ZVqZCx4nCWNVDijQdi/CLgOj9OCo254b6zzEFkFL8a/TO9c73JTUFb0KqAmCDc2+GqHpHu4v9K6pecB+7VblrRUKpr85wfclA4dD2zm8G/zh5ZPkkVEgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662711; c=relaxed/simple;
	bh=sqMmVYyUYpGstje1wz4BDAufr1v680Vkae44YBH6/xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8yhLUFWSEeeYkcGO3ym4nrz5vN0DGqjEYfTBdeMDo+Zzmsdob1lR2ia3fvZlkHCuKTZSR1ruZp5Q9NvTu238RYF5Z0moxWob2Q5xiwmX1w4ZIQdmhYyr+nYHx/2rd1PhEAVLvvviJJFRFeEd1yxa7QuD3TiJ5T107gHFDoVqZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSXQtycm; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSXQtycm"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-436263e31abso3299282f8f.1
        for <rcu@vger.kernel.org>; Mon, 09 Feb 2026 10:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770662709; cv=none;
        d=google.com; s=arc-20240605;
        b=g7ZA+8XEPtl7K50qVHpEUAI7jw5+TYSXVV0UQInsPZY9G1Nmc8EFUehFiMrSGiTzBI
         w9SrJ5++NFAYN47cs2DeXJb9lyv3PlaO28BXit+k8o4dJHWkBnvFTGzc6mmjU73hEWln
         W65/wsuVsjxis1hocbjfavsvIJaqast/REAwyP3qVDcMMb710IOdYRzoN+TcC5xdB/go
         fQR9d4QOmW8+TIr5EMVEJ6gEE7vxSHdoBtfWXzyo5U5oNPXYtmQiXfoF4+yEtSDpWq9v
         F4C5aAA1FTARGoTFuO4cs9rC+WfNWsOGMWtpP7EhrP6Chl87rR39EjGGZ+BdenulRj78
         iPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sqMmVYyUYpGstje1wz4BDAufr1v680Vkae44YBH6/xk=;
        fh=H7uomwcc+/NZAyF7nkLxE9ddI9q2Sw8HEXYzeaxtCSk=;
        b=PvF/nmKW6gtb89vj97j+toIMj46Y1JvxInuyCMleRC8FuRNfpBu6iLejf3fzQ+w9U0
         7Kgd7RYfPXma+TwxjxrYJ92sYU6HPiBJPYxUfANl1M7Ta+uz+xMBKi0HQiHW3vvLtbtj
         4tEgiNN883j4Isf70AHXXcCRsNU1NbmCwq/17OI3YzZzFCGDm6lH3vlKNEmgUdIDJJ6A
         QsfM9sGrWRJeHYmJY9gCoYuXIanuUWy7V4WNAfCF5tXU9gxzKQ7HLsBBOyOPDKn8VFo3
         PEHJBsGoenfK8a3a+GQv3e+L2dmU62yfl52keOnzVjHctD85Or9qEPT+8Ay7GxbBcf3j
         cxJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770662709; x=1771267509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqMmVYyUYpGstje1wz4BDAufr1v680Vkae44YBH6/xk=;
        b=LSXQtycmfmH1+2BCwo+kK1vOtMr0AbFNbYR0G518XT49Hk9usOWDH6MR1QcBK3QVjZ
         gUnzpUJRsiks6wnWYUigoGGA4pi27cQmoM7L60DIpMUoDubOnoEFmdLHvbNYAwgUobUN
         vqmUKsdnHCHfFLoh15g6mz0MQ38Z0nrAWCLJFp5HkzdbEDGlqrD27c5XNkc2PjYk3K1a
         aeVN2M9Hq77LHdGmJuqxa4OUBcYIjtHFFBtsMhBlXAZBDv/6lKgDXBhOGWPiW8Mf34Fl
         kpa2WVe1BjdaDwWI8AUR+n3D/qSKMwiUsyE9cs9jvP9BedO9ropUNEteGdSHZG4GvrqZ
         Dc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770662709; x=1771267509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqMmVYyUYpGstje1wz4BDAufr1v680Vkae44YBH6/xk=;
        b=F01dX0VpWvMMgNaVllMXaUbFr2rNBOb/Nyr6WzAYF4PSoKbEN2nbashUwDnJ3XfvPm
         QXZV7ZrxAmlOPPkJLxpPFHvlGxFFC091a+yzEM5/eaxwDUMc9TqSe8MY4ZAtUHGKZebg
         OXkpprYHuV/5xGWJ4KL9KA1R2SR3PQ0z1aMy64OazVYU9looJ1kHKSScSqRcgDL6C2+j
         g1wl1Sb0oHR3ds2F9a9A9u57WJXZdQAT5S4fllbf3aBbZTP9k5r3uqeEaNzC/ovSZIFl
         gXkr9mDWCBbuh+/YvUevlSXa1/KvUKgsmpAoHKzxEt+r0A2djAxCTFvaX43ij7ax6FMM
         9Ajg==
X-Forwarded-Encrypted: i=1; AJvYcCXdqEQ9BOv+eazAbcrFMpa+U954GqHJVFDGhP7FJg1AiHz2CWGlBctRqqxVhuYBlzpr/0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBCYYc9sjL+jjSKgVGPWImYQNXM5wI5JZA206dRpp7oSlKiQ2
	HFffBqa9RgDaa0yuAmEh2m9YW+459hNJA52jhC6n524jHdR0KQ4P3p2NrkEcNT57yetJRUOV5bf
	76c7QlW84PxpFXPqIslC+XZVb9S03mq0=
X-Gm-Gg: AZuq6aKqsve/cKAKV1Y4lgjTDD7Tvv3e1dnNtUyMVcJsgqXsfdTsTH/qVAmPppovoN5
	TS5SdjmoF3bh0tr5HQgqGGNmFtd4SSjyp2NgTU1VXq7TAtj5PYoVHDq0hPOWCKe68f90Px3ciVE
	E/MMfAiP/u/UNOzjz3dW0g1/47ujkzeHy8ztJEZkJlU3RILl+++u53WWsm7DlXyVOAP+9Q0wCO+
	AZUihgMptTFie4Pf5w7sMzOgdHG+FUCQdoliYUiT3/K96n6dDVRMBscvm0rRsPrcTMJGdC64OlN
	s/vapzXJRkyMeJcGXxtHgRL0CRgLJVaZlRnrmtAK8s9b/tIeiXzO3BTaPEzmoIFF2XZt784qjCZ
	7D6XDiNQA5Z3VAg==
X-Received: by 2002:a05:6000:2285:b0:435:a0ca:bdce with SMTP id
 ffacd0b85a97d-436293b6d91mr19720428f8f.63.1770662709254; Mon, 09 Feb 2026
 10:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206093410.160622-1-harry.yoo@oracle.com> <20260206093410.160622-5-harry.yoo@oracle.com>
 <CAADnVQ+rNYeb5Pu2aHRVc+hYDeAF5t19MVwzXsyn2HkOuLPNLg@mail.gmail.com> <ebc2eb77-722d-4966-8376-f11607de53c2@suse.cz>
In-Reply-To: <ebc2eb77-722d-4966-8376-f11607de53c2@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Feb 2026 10:44:57 -0800
X-Gm-Features: AZwV_QhH5LLE8iIvDB7Twan7nOo9YGILnwQ7hrloMARMGnUSRQtlNRKOCRmQfK8
Message-ID: <CAADnVQ+q3QPqNdV3MuysQJQgxSS4g6CV+VzN2=UqCPHw7xq=SQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] mm/slab: free a bit in enum objexts_flags
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 1:38=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 2/6/26 21:09, Alexei Starovoitov wrote:
> > On Fri, Feb 6, 2026 at 1:35=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com>=
 wrote:
> >>
> >> Since kfree() now supports freeing objects allocated with
> >> kmalloc_nolock(), free one bit in enum object_flags.
> >>
> >> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >
> > For patches 3 and 4:
> >
> > Acked-by: Alexei Starovoitov <ast@kernel.org>
> >
> > I think patches 3 and 4 are ready.
> > Would be great to land them for this merge window
> > (if Vlastimil agrees).
>
> We should have an ack from Catalin for kmemleak. Also better take them ou=
t
> of the RFC and send as 2 non-rfc patches first, with cc list reduced
> accordingly etc.
>
> Then I can put them to -next and try sending second merge window PR next
> week. Can you also point to any bug reports that would be fixed? (that yo=
u
> had to work around or delay merging or something) that would help the
> argument to not wait a cycle.

Here is one example:
https://lore.kernel.org/all/20251114201329.3275875-1-ameryhung@gmail.com/

"
RFC v1 tried to switch to kmalloc_nolock() unconditionally. However,
as there is substantial performance loss in socket local storage due to
1) defer_free() in kfree_nolock() and 2) no kfree_rcu() batching,
replacing kzalloc() is postponed until necessary improvements in mm
land.
"

This patch addresses both 1 and 2. The freeing is done in a good context.
The only reason we use kfree_nolock() and suffer from defer_free and
lack of batching is due to kmalloc_nolock()->kfree_nolock() matching
requirement. So this small patch is a big deal.
We will be able to use kmalloc_nolock() -> kfree_rcu().
