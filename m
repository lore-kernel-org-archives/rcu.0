Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75F3B7B7D
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191545; cv=pass; b=BCT4Zh5fq6ze8/C2uO5OlNOIakwCWR7SaLwjTlPz+K4V2Ju6HD0yAqWTecseI5AVP4kpae20Y5EDuRm+ZPfioSeGwsjnG9GeJK/auADq38TE+thiBzAg4tLP82F3m07+ZQ8M0sBIg8+AFY8+UddqLWhe4wBjSFNHD7M36chYVRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191545; c=relaxed/simple;
	bh=DTpJoqcps9RyblLs1PlT4OUx7eE0BfdGkN12l+SH5S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cp5NJUrvAX9NboI3rRXEL5pXzBibvoo3SAXY9+dOLN+FL0JCSsnLE9pB/EEGtqmklAj/Yctf7DZyh592tCaBGVKZFuSmZc5F1uudCzao5Y4t7ioud244XmYvOxQvrzf2csoEnARrv4Y+Z2IAEMo4SCJP+8ZSbH+7wYo/qkuIggQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbpiZVvn; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbpiZVvn"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so794605a91.1
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 12:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790191543; cv=none;
        d=google.com; s=arc-20260327;
        b=NOU6WWtlk2Q3sDWInhLGY85LhNKu1qyOZUpPS+5fq1GwHC4GWcFwVW+OcMhcUbDgnR
         MWw1K1BiTkV6N9CJ6nZXRiI+f9kci3NpLXm31S0HPaRrNWT07rZzhrSNmH88mZ8bYjfK
         chRcMsClpXf792lTfTs2k+/AMx6x1HcUQ/CRVWkyoYlXMX7lE5R9R350AKWdVMDAUZqS
         C8GKJdJj+sAnoFLLEtaYjDCuDvkOmEZvVmbwpShJdToS3bBfPNJMk03uGU67k5DFSnqk
         USm95vgrIEUC/mm65A2IIz3JcE52eIYAflYEImJMbNTc8NvVp5IXpp3BFWlTexL5i8OB
         N6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z7c0VL7zF9YMH7MNJ9a73b3SqFY7TUHxkX3PupMjtc0=;
        fh=Yrcll43qfeXHL8joEkjcMlkTjWbECHgDEMvze5EnTWI=;
        b=GTWhweeVEmt8u7Td991BsU4Czyrx4bNhNIm0yywkKaMujV9MxbVpv1C9IR9fHt0Zka
         QcITRx711k9LQ7PrpCu1EY6e24OeLsDcqxFhwLvyA8Wp0DxpgsjRrSEuDkIMKxWDVChU
         MATKWKTlPLtzV7iYiTGPKDYDMhZoD8wffj87WHsRWKDeSLptsKwILczqBsjrxAFdC9aH
         W9qaH9jimm3bvjXvpACSEni3tYUbbxA+EkMUMSUNs30in0xd6AZufvyV3IcJ1Enqvc/s
         adrS1XmG2FHBYEU7FB1apVE2ojuONKJh41ExlMa5zJtI/kYbNG9g8ff7odYRYaV8/Qi8
         66vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191543; x=1790796343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z7c0VL7zF9YMH7MNJ9a73b3SqFY7TUHxkX3PupMjtc0=;
        b=bbpiZVvnj/aQZev0GhKj/AVXfqEhAaEVukqv+DDs2VXpRZAuZfwBbJw5EsG0gvI0yu
         HTL5HSmXF62ezCa4BnOJKoxb8snqnqFeoxN4T9YyXzVdj7t4wbyjABKPQIHyWP1TGYJo
         gmiFTJZKD1nBFy3lEnlaLjYfeZTG39dZsWcmkYaQqmIEfta5lq8od8KHycTtC0YcTEv8
         03W3LLUf/RZPWSF0Sg2A7TGDYrHwYW5BiL1868iEU7tX6MeCmVd0aycHukVa3qB7gE8K
         thqUB0nt4J4YubJsuHYZzeXDYn+QH8JX0D0XKfOUvYAQZiwDpXXv7ybYwfRMZJgbdtOP
         Pggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191543; x=1790796343;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z7c0VL7zF9YMH7MNJ9a73b3SqFY7TUHxkX3PupMjtc0=;
        b=dS0QyyXdwJvlZK9UbrQT/S6NVoaJojZizO+8uAEkPR1gLCDOWReMFCs1673P4JwESG
         Fh8QnsQBEnFQ7bt7U8rgh2UP+1mrIkrju+1MEQ/gWCApcpzbLxubsj9k917LVkRWLEHd
         PbHGBlZUW2O1II6rSfMbM6c2zB7bDa2IhI4cMvCej8xY//xh77C9xzisJDl/LW/YElXo
         qyKw1/9x7UMzP7uLnOBl1+0wZVvx0oPKAHgTA6J6p0HGdEcvngAuWfI1ojwU5W2qWNaX
         avG1tUrgdNY69Qf0HRvJ00hUi/2SLmeJ4axXFOBPwU/fR+3tj3Hf9+PQv4I41wmpwHQ2
         ED8A==
X-Forwarded-Encrypted: i=1; AKwUvBzZW6o5LasZF+WQTqzWueJnz2enTuEZOVXs25qe6s9cZ0WLkyITvhTIPIFn4EkPPbfgwhE=@vger.kernel.org
X-Gm-Message-State: AFuF++lS3aSHtN/33ZDVhI2DEwqCe/ys34LAYYY9bqDBjdnRv1zwAqat
	UNFUVIRhYPOMztW9L2U5056f/0/hI92rfxtcOLs16w54vHG3nCY8ESCLlbzM+frg30odmQT1TK2
	RvI6e1EoBRbgElqwmXYxfqVFLTGvFp6Q=
X-Gm-Gg: AYBFou1Ze4PYOxyo4rzPuDg3iIgJv70IOg/3FzMTessZf0N6jOkENOga8c1EgOe8ZqQ
	/icXz6+ctoQV1FN8EdnkH3P9vxMDrukOO/lvI0xlxJe8C24FE/Xm3CbTg2rP5YbVBIRE05cTVHn
	w5UuObS76QHDhc7BTvjtz4WClDVlFasoq6UShbb9DqCext7IE70QoT2196AheErVR4i+hJTVsvc
	3nsolKek5JyL15EkbKHlLpcYb2aKbF0oHQ2TwR30eD8fmMYOqpynywJ59utC3k33O2LHznZQVFf
	92WlNln4IGx0pRujcycbSLUDNNTyjorDSOQgGpIf36+dgU4U7HkVMRHMJfacqWo6+9hZiSoSzFl
	TzKpk3YWLoErRrmSHnbMzyVYP1jWIwPEAsrAsEQ==
X-Received: by 2002:a17:90b:4d09:b0:39f:d323:c988 with SMTP id
 98e67ed59e1d1-3a098dff5e3mr90526a91.48.1790191542592; Wed, 23 Sep 2026
 12:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200208.3203834-1-puranjay@kernel.org> <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
 <CANk7y0g8Mh-je_o_nyXQ3zsGVeAsz2qMfgDtv4j-MXhAJ7PcMA@mail.gmail.com>
 <DLMNTHW945RO.TLPGJHZRWHUY@gmail.com> <CAEf4BzaR=oQz13GVxM+DjLkyjCjFmETvj9=bAuccLNKCXHJPaw@mail.gmail.com>
 <DLMUP8JM4L3U.1A9R0QUFFIQV9@gmail.com> <CAEf4BzYvSXNKu2qtBHEvmFg8sm3yJS_2xRUmuQhfjfx79VfgNQ@mail.gmail.com>
 <DLMW293TO3P3.3SKQ637LNLYQR@gmail.com> <CAEf4BzYLZtHvD9s8N9UA-VmHUD1zKO=kQhKDvxLHHWQsFgu_cw@mail.gmail.com>
 <CANk7y0g01QX-0ZqtF9FhL-9pmrLtXqyRVsyQo1UE9A-wTaO16A@mail.gmail.com>
In-Reply-To: <CANk7y0g01QX-0ZqtF9FhL-9pmrLtXqyRVsyQo1UE9A-wTaO16A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Sep 2026 12:25:30 -0700
X-Gm-Features: AcwNN1UtvFSbvMz0aiDzYNPPWIXwg7ucvzyEtCIQhhnTLRq-3wZ4AAVRMQuDWmQ
Message-ID: <CAEf4BzYs=PiHMzbLU9rt-O1kRff4_yOzopK_x4bfOgmhN0h9=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:31=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> On Wed, Sep 23, 2026 at 7:22=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Sep 23, 2026 at 10:57=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Wed Sep 23, 2026 at 6:59 PM CEST, Andrii Nakryiko wrote:
> > > > On Wed, Sep 23, 2026 at 9:53=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > >>
> > > >> On Wed Sep 23, 2026 at 6:45 PM CEST, Andrii Nakryiko wrote:
> > > >> > On Wed, Sep 23, 2026 at 4:29=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > >> > <memxor@gmail.com> wrote:
> > > >> >>
> > > >> >> On Wed Sep 23, 2026 at 12:37 PM CEST, Puranjay Mohan wrote:
> > > >> >> > On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
> > > >> >> > <andrii.nakryiko@gmail.com> wrote:
> > > >> >> >>
> > > >> >> >> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <pura=
njay@kernel.org> wrote:
> > > >> >> >> >
> > > >> >> >> > Changelog:
> > > >> >> >> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-p=
uranjay@kernel.org/
> > > >> >> >> > Changes in v6:
> > > >> >> >> > - Size struct bpf_rcu_head at 48 bytes rather than 64, mat=
ching what the
> > > >> >> >> >   inline state uses (Alexei)
> > > >> >> >> > - Trim patch 1's changelog: drop the reasoning about possi=
ble future
> > > >> >> >> >   layouts and about what the other async kfuncs return
> > > >> >> >> > - Rebase on bpf-next/master
> > > >> >> >> >
> > > >> >> >> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-p=
uranjay@kernel.org/
> > > >> >> >> > Changes in v5:
> > > >> >> >> > - Rename the "hash_map" subtest to "bad_map" so that it ma=
tches its
> > > >> >> >> >   helper test_call_rcu_bad_map() (bpf-ci)
> > > >> >> >> > - Bump the callback counter after chain_err in the selftes=
t callback.
> > > >> >> >> >   Userspace polls that counter and then reads chain_err, s=
o it could
> > > >> >> >> >   still see the initial value before the re-arm had stored=
 one, which
> > > >> >> >> >   let the chain subtest's assertion pass without checking =
anything
> > > >> >> >> > - Say in patch 1 why embedding struct rcu_head in a uapi s=
truct is
> > > >> >> >> >   acceptable here (Mykyta, Paul, Alexei)
> > > >> >> >> > - Rebase on bpf-next/master
> > > >> >> >> > v3: https://lore.kernel.org/all/20260915143640.36292-1-pur=
anjay@kernel.org/
> > > >> >> >> > Changes in v4:
> > > >> >> >> > - Drop an unrelated hunk in bpf_async_update_prog_callback=
() that turned
> > > >> >> >> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer=
/bpf_wq path
> > > >> >> >> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would=
 have changed
> > > >> >> >> >   the errno bpf_timer_set_callback() and bpf_wq_set_callba=
ck() report to
> > > >> >> >> >   userspace (Sashiko).  No other changes from v3
> > > >> >> >> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-p=
uranjay@kernel.org/
> > > >> >> >> > Changes in v3:
> > > >> >> >> > - Move the bpf_call_rcu_tasks_trace() verifier bits from p=
atch 1 to
> > > >> >> >> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolv=
ed symbol
> > > >> >> >> >   bpf_call_rcu_tasks_trace" (Sashiko)
> > > >> >> >> > - Poll the callback counter with an acquire load (Sashiko)
> > > >> >> >> > - teardown: v2 only checked that the program was eventuall=
y freed, which
> > > >> >> >> >   passes even if nothing was ever armed.  Also assert that=
 the chain ran,
> > > >> >> >> >   and read the -EPERM back through an independent .bss fd
> > > >> >> >> > - Use kern_sync_rcu() instead of open coding the grace-per=
iod wait
> > > >> >> >> > - Return -EBADF rather than -ENOENT when the calling progr=
am is going
> > > >> >> >> >   away, matching bpf_task_work_schedule()
> > > >> >> >> > - mismatch_map now pins the bpf_rcu_head label the new cod=
e emits; it
> > > >> >> >> >   passed with that branch removed.  Add a two_heads test, =
and wait for
> > > >> >> >> >   each grace period separately in the chain test
> > > >> >> >> > - Commit messages: correct the -EPERM parity claim, explai=
n the inline
> > > >> >> >> >   callback state and the struct size, motivate the tasks t=
race flavour
> > > >> >> >> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-p=
uranjay@kernel.org/
> > > >> >> >> > Changes in v2:
> > > >> >> >> > - Rebase on bpf-next/master
> > > >> >> >> > - Use rcu_read_lock_dont_migrate() over open coding (Alexe=
i)
> > > >> >> >> > - Improve re-arming selftest to detect failure (Sashiko)
> > > >> >> >> >
> > > >> >> >> > BPF programs that manage their own objects have no way to =
run their own
> > > >> >> >> > logic once an RCU grace period has elapsed.  bpf_obj_drop(=
) defers a
> > > >> >> >> > free, but returning an index to an allocator or unpinning =
a resource
> > > >> >> >> > once readers are done has no equivalent.  sched_ext's BPF =
library works
> > > >> >> >> > around this today by pushing freed nodes onto a list and h=
aving a
> > > >> >> >> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) an=
d then run a
> > > >> >> >> > BPF program to reclaim them; it is the first intended user=
.
> > > >> >> >> >
> > > >> >> >> > Add:
> > > >> >> >> >
> > > >> >> >> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *ma=
p,
> > > >> >> >> >                          int (*callback)(struct bpf_map *m=
ap, void *key,
> > > >> >> >> >                                          void *value));
> > > >> >> >> >
> > > >> >> >> > and bpf_call_rcu_tasks_trace(), same signature, which also=
 waits for
> > > >> >> >> > sleepable programs.
> > > >> >> >> >
> > > >> >> >> > @rh is a struct bpf_rcu_head embedded in a value of @map, =
so the
> > > >> >> >> > callback runs as callback(map, key, value) for the element=
 it lives in
> > > >> >> >> > and needs no cookie.  The field is only accepted in BPF_MA=
P_TYPE_ARRAY,
> > > >> >> >>
> > > >> >> >> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily r=
estrictive
> > > >> >> >> in practice? Do other APIs of similar kind have this limitat=
ion? E.g.,
> > > >> >> >> bpf_task_work_schedule() or timer, I don't think they limit =
user to
> > > >> >> >> just ARRAY maps, it's way too inflexible.
> > > >> >> >
> > > >> >> > Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. =
They can
> > > >> >> > because they can cancel: on element delete bpf_obj_free_field=
s() calls
> > > >> >>
> > > >> >> bpf_obj_cancel_fields(). bpf_obj_free_fields() is no longer cal=
led except when
> > > >> >> the object is being freed finally.
> > > >> >>
> > > >> >> > bpf_task_work_cancel_and_free(), which reaches task_work_canc=
el(), so
> > > >> >> > a pending callback never runs against a recycled element.
> > > >> >> > A queued RCU callback cannot be cancelled. rcu_barrier() is t=
he only
> > > >> >> > thing that waits for one, and it sleeps, so it is not callabl=
e from an
> > > >> >> > element delete. Array elements are never freed individually, =
which is
> > > >> >> > what makes it safe.
> > > >> >>
> > > >> >> If cancel is a noop, can you not simply skip it on map update?
> > > >> >>
> > > >> >> It is a bit unfortunate we can't provide cancel semantics, it w=
ill be yet
> > > >> >> another divergence from how all other async callbacks work...si=
gh.
> > > >> >>
> > > >> >> >
> > > >> >> > I can think of a complicated way to support hash maps but tha=
t would
> > > >> >> > need making the state dynamically allocated and finding a way=
 to
> > > >> >> > cancel the callbacks. But I would do it as a follow-up if the=
re is a
> > > >> >> > real use case.
> > > >> >>
> > > >> >> That would mean allocation and frees, it is already quite expen=
sive as is for a
> > > >> >> call_rcu() primitive (with the refcount bumps and atomics).
> > > >> >
> > > >> > maybe so, but as is ARRAY is a severe limitation and makes a lot=
 of
> > > >> > cases either unusable or requiring extra sequential ID allocatio=
n
> > > >> > logic to remap some HASH map entry to index in an ARRAY map, jus=
t so
> > > >> > you can call rcu callback for a given kernel object stored in HA=
SH
> > > >> > map.
> > > >> >
> > > >> > E.g., think about keep as set of sockets, or tasks, or whatnot i=
n HASH
> > > >> > or RHASHTABLE (especially the latter one with support for resizi=
ng).
> > > >> > How would you do bpf_call_rcu() for them with unduly complicatio=
ns,
> > > >> > limitations and a lot of waste (unlike HASH you can't have lazy =
memory
> > > >> > allocation).
> > > >>
> > > >> Yeah, I don't disagree. We would also need to support storing them=
 in more map
> > > >> types to make it woth with arenas (which was one of the motivation=
s for the
> > > >> feature).
> > > >>
> > > >> Perhaps it is better to make cancel a noop / unsupported and skip =
it when a map
> > > >> element is deleted. That will be the easiest path to enabling it, =
but it does
> > > >> create (perhaps surprising) divergence from some of the other asyn=
c callback
> > > >> primitives.
> > > >
> > > > I don't see much need for cancellation, but a more useful/sane
> > > > behavior would be rearming on subsequent calls to bpf_call_rcu(). T=
his
> > > > would also handle update/delete/reuse of entries. Not sure how hard=
 it
> > > > is to support that in kernel's call_rcu() implementation, though, b=
ut
> > > > that would solve the problem, because it should always be OK to del=
ay
> > > > call_rcu() callback, but not the other way around (which is what wo=
uld
> > > > happen today because we will ignore subsequent bpf_call_rcu() calls=
).
> > > >
> > >
> > > Hm. One of the design points for this was maintaining our own lists a=
nd using
> > > more lower level RCU primitives to poll for the grace period. I wonde=
r if some
> > > of this could be made easier that way. I will think a bit more about =
this.
> > >
> > > We could probably also do the waiting_for_gp amortization that memall=
oc.c on top.
> > >
> > > >>
> > > >> That said, I do think performance should be a consideration for th=
is API; maybe
> > > >> unlike other ones, I would expect that this could be called very f=
requently. I
> > > >
> > > > I'm not sure why this has to be super high frequency API to use, tb=
h.
> > > > You'd normally use this when cleaning up when some kernel object is
> > > > freed, no? Sure that can be relatively frequent, but not to the poi=
nt
> > > > where we should be *that* concerned with refcount or atomics overhe=
ad
> > > > per se (multi-cpu cache bouncing of refcounting is a concern, but n=
ot
> > > > sure what you can do about that).
> > > >
> > >
> > > Yeah it depends, but I think you can make the other case as well.  Go=
ing by
> > > optimizations made in memalloc.c for hashtab, imagine implementing an=
 arena hash
> > > table using this stuff. You'd definitely want it to be as cheap as po=
ssible and
> > > approach the kernel implementation.
> > >
> > > If multiple CPUs dispatching it leads to constant cache line bouncing=
, it will
> > > fail to scale with number of CPUs. The user then does their own batch=
ing to
> > > amortize the cost and pace the calls, but it's just more complexity p=
ushed down
> > > on the callers, and it might build up memory pressure because items a=
re now not
> > > being freed as quickly and hit locks in the allocator (one of the mai=
n reasons
> > > BPF maps have memory reuse semantics, to avoid exhausting caches and =
hitting
> > > allocator locks).
> > >
> > > Anyway, I know we kicked the can down the road for now on prog refcou=
nts, and
> > > can cache allocations etc. to amortize the cost there, but I hope tha=
t I could
> > > illustrate why I think it might be more sensitive to performance diff=
erences
> > > than some of the other primitives.
> >
> > no, that's a good point, but I think the solution here is to make
> > prog's refcount more scalable by using per-cpu refcount approach,
> > right?
> >
> > >
> > > >> had concerns about prog refcount increment as well, but didn't rea=
lly bring it
> > > >> up since it is something that can be addressed after the fact (may=
be using pcpu
> > > >> refs). But once we promise supporting cancellation, it is hard to =
walk that
> > > >> back. I think it's less of a concern for other async cb types. In =
practice,
> > > >> except to support map semantics I don't know if anyone will use ca=
ncellation API
> > > >> either, the kernel side never grew such support.
> > > >>
> > > >> Anyway, overall the best path to me seems to be just enabling it a=
s is and
> > > >
> > > > you mean enabling for HASH or keeping it for ARRAY only? If the
> > > > latter, my concern is that to support HASH we might need to change =
the
> > > > internal structure and break that 48-byte size, so we should probab=
ly
> > > > decide all this before we get this into the next Linux release.
> > >
> > > I did mean enabling it in other maps, yes, sorry, I think I wrote it =
in a
> >
> > ah ok, +1 to that
> >
> > > confusing manner. I was just speculating that we can bail on cancelli=
ng and see
> > > whether we can make it work. I probably need to spend a little more t=
ime
> > > thinking it through.
> > >
> >
> > I think there is, I'll let Puranjay provide details as we just had a
> > discussion offlist.
>
> I think I can come up with a way for supporting hashmaps, by keeping
> the element alive until the callback has run rather than trying to
> cancel it.
>
> On delete the map asks the head first: that sets a dead bit and
> reports whether a callback is still outstanding. If one is, the
> element stays unlinked but is not returned to the allocator; the
> callback does that at the end through a new map_release_elem(), since
> only the map knows whether that is a freelist push or
> bpf_mem_cache_free(). The dead bit stops it being armed again, so
> there is a definite last callback and exactly one side releases the
> element.
>
> That needs one more bit of state in the head that covers the rcu_head,
> which RCU dequeues before invoking so the callback can still re-arm,
> and a count that covers the element, which has to live until the last
> callback
> returns. Both fit in the u32 already there, so struct bpf_rcu_head
> does not grow and there is no allocation.
>
> What do you think of this approach??

I haven't looked in details into the current bpf_rcu_head
implementation, but overall all this makes sense. Please give it a try
and let's see how it ends up looking and working.
