Received: from mail-ej2-f17.google.com (mail-ej2-f17.google.com [74.125.228.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3A491581
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159911; cv=pass; b=Nq5u5ue70V/L910msbb+TkvzAwO69NBBbQ3n8vBypkNKks2OL2jmUyRezZaJBhxaDrU+XFQEzu9nzx1jnFqbV2AdYXlrunKA26ALVsx6SARN1gWLptXxrkNjGk0t5jSBd3mh05V3SafPPiflSM7BGHp95sOwp+5UawgZxIMSnus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159911; c=relaxed/simple;
	bh=5bBZTIhJ1VDX0f09EYU0W2JJIYCCiRMPtgnSccz0QeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKFozcGp20586Kgmp4JAa1cz+ku+Cvj/xWdabQXrCDmjiWn+tscwG5x3H3Emloi8rguEr+9NLidS1OfpOJJ8w8YuwqBD9ny+J5Lltdg6CBxoJh83UhMXalstIqeP+5GS0ycSNwrqsvsNZQAf0EgWM9eadh8IbiQAKzm30LwRJww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqta2/s1; arc=pass smtp.client-ip=74.125.228.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqta2/s1"
Received: by mail-ej2-f17.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so100225766b.2
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 03:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790159894; cv=none;
        d=google.com; s=arc-20260327;
        b=a4HvHAIRsiZFRCTj0/1CQnlR4dVgLtILe6bM5rU2/MnxEE0URkPGIqfWDKXBGlmUog
         60bTKaK0P2hErUGtMJwCx0ki+4RqIRt61yV7sQ//0/VyZZ8iDCz0T13x4vropWzG3OjQ
         9gokladtYI8YyvkNXfUcfL88IAJx0XnI6xLdxrm5ua7hutDGKeSTtfrsUGHS0C3++E6T
         a0wkya/dXJ+EyZv36zN19GNEPUOAPZS6LNmA8MsqNoO+wsAb0DBAUqFsVitYf8lvTOqQ
         7+sKXOMc688qq0k5rj1LVt8kk6cpzIOL+ryOZE4NLH3BJokRh7qApGZ9KwpMIqvAINk8
         cUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NOmzl3Lo3C4M70pbXlcdYKKFRiDhI9/7UZkmUgMpPVo=;
        fh=NkFrC+NzNAXjyvZABeueg7Y6R/K10lZvQiVjSW1v52k=;
        b=VQOSgzXPzmmVXVk24c5YAAs6yuaovljmFknPDmZMcb46OaFtlbfS+jcvOfzncbQiix
         iL7AU+xPlArf1iLjQmleBueaEURlEtg1NOna/LQbBIwsxAeV+EdtkgIFjXAyV+A/W3Jb
         Uvu8KJCGmqoBMYjZLKEJJEZNMPbaEmWnAJBx3Kn6cg7xhQ77lZvpN010XekOoyfaLfOU
         ldNdDDSwpAX32Epg+EchnoqMd6bZkmU355ObcLwhSYPsVhtNqjmeF715eAKiBNBNGGkC
         YXVrWS4/ofMxXhxmhQpzJoJWprqDhP2+5uGO0npgrqeUI0mLjS3HV3UcqbjNEVGTSkMc
         9sUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790159894; x=1790764694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NOmzl3Lo3C4M70pbXlcdYKKFRiDhI9/7UZkmUgMpPVo=;
        b=rqta2/s1wmXwbb65CLXFEClUsYZTaKfHG2jSvl4kLCBGO7Pd5MHaj4nUEQErEK5fd4
         mq07rlHMKtTrONqugQhH2rPPmGVq4fqTNIsOBu6PQ7ncLHN4snOrPQqMGTJifbCSdUtn
         9/ma/4yTtHlaTmkfOpghMyoBmtAjz1F5SF2C2f3zjf5zxuhvZkuKZmqtwLwwFO7eNc9H
         FReOFqdlxycVgbD67xrRf4LPJDVYmh8sKngZ6HYz3EdaaDZdZQOZRebr3dl+3k0scZid
         nYjNvk82c9sV3xHZv2dlmVCb5Ymo84GwoSvXHz3Hwdxuj0PkqxsIFADNr3M9Q79/BOKy
         Dd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790159894; x=1790764694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NOmzl3Lo3C4M70pbXlcdYKKFRiDhI9/7UZkmUgMpPVo=;
        b=WMUsD/XK4kwKkIlrv0FeR7Sb9qNvXJcRfiTG4XjHCe1ypvMQOcYsezNZ0hnF1bt1ZZ
         BWYQ+cUaZkidPEALjSvM+5A3qjRb7UhACqqIrPqBcrUYxwfzQUAqvaxIM7D3uIaU9y0/
         HJJsXRABbfvrEIJr3uZfo+3fERw3nG/7jywONwm1bZP6hYeX1lYkIc5rAmp/WIU6spGQ
         eq1YITsVnGh4TulSrK3ujJJ9M6tCIrwIzgxgfIzcHlX0kKhghfZGnfOgE2ttcUu/dKS8
         Gmh02ti3xxcRZ46oJoTMItp2Lk/P4MgV8JsXmnzecnhv8+axF5qe8ASdwC3eOHZx1gK3
         g7Fg==
X-Forwarded-Encrypted: i=1; AKwUvBxAoceryPIjCwPGpxPGtqd+2KEwTurWr5GmbKeTbzRcryWxmRjDLhEEheWhulwuwZCIrVM=@vger.kernel.org
X-Gm-Message-State: AFuF++mMybFNNxG8s6GmnwHPsSo22yDZ7yooE0yLWrOpj8i6Jkg9bk9P
	Z6v6w5U68Xca+XPniCk12KiT1PlFGqf7jIQiKS024uQHiyPDHc5M2MM9Npj6dPzTZ0K2EEjOtRp
	PUYe8c7ccxcrfS3OP0KvmcveJf8uPwxQ=
X-Gm-Gg: AYBFou1sjB6aOZsHUkb/TDgOjlxyGJPtx8aicWZsAYjHWQxvYAuHOBMoKMfh/lk1mZJ
	dxg2aYp9ZXCmRzTGMr/jtQSAO27I3cq8iMlAgZqVGEe8Ed3qIr6hIam+9TyP/EgKJs9fj8MfF9d
	Gvh7B4198AFSO1SpMmgLK60YTaKJ9+dkvJ7NmcaU4r78tzlRwcDBIZJY4ZuJkyEH83vegv/dYrL
	30bpVVizrg+cWOoArJ3ajxUPaikk0EcumoSqVQdDgsABGZn61YIBlnSU30hsNr2f/fCT2DevlBD
	R2fnFJ/Pl18ewx6SUlzJfYkMklukVsS17DMu51Mzi2JPcZcOsQqTsGKyvMosnosOzPISNEo=
X-Received: by 2002:a17:907:608a:b0:c29:555e:bef with SMTP id
 a640c23a62f3a-c2aadfc5b2fmr163903866b.9.1790159894167; Wed, 23 Sep 2026
 03:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200208.3203834-1-puranjay@kernel.org> <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
In-Reply-To: <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 23 Sep 2026 11:37:59 +0100
X-Gm-Features: AclHuK8pdOJUxuHrx1JIbWKYUF7JdvDFBS4P-u95gPodKlFXuPe3W3Au750rJNg
Message-ID: <CANk7y0g8Mh-je_o_nyXQ3zsGVeAsz2qMfgDtv4j-MXhAJ7PcMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:41=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > Changelog:
> > v5: https://lore.kernel.org/all/20260921191407.1742386-1-puranjay@kerne=
l.org/
> > Changes in v6:
> > - Size struct bpf_rcu_head at 48 bytes rather than 64, matching what th=
e
> >   inline state uses (Alexei)
> > - Trim patch 1's changelog: drop the reasoning about possible future
> >   layouts and about what the other async kfuncs return
> > - Rebase on bpf-next/master
> >
> > v4: https://lore.kernel.org/all/20260915154248.3612028-1-puranjay@kerne=
l.org/
> > Changes in v5:
> > - Rename the "hash_map" subtest to "bad_map" so that it matches its
> >   helper test_call_rcu_bad_map() (bpf-ci)
> > - Bump the callback counter after chain_err in the selftest callback.
> >   Userspace polls that counter and then reads chain_err, so it could
> >   still see the initial value before the re-arm had stored one, which
> >   let the chain subtest's assertion pass without checking anything
> > - Say in patch 1 why embedding struct rcu_head in a uapi struct is
> >   acceptable here (Mykyta, Paul, Alexei)
> > - Rebase on bpf-next/master
> > v3: https://lore.kernel.org/all/20260915143640.36292-1-puranjay@kernel.=
org/
> > Changes in v4:
> > - Drop an unrelated hunk in bpf_async_update_prog_callback() that turne=
d
> >   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf_wq path
> >   and bpf_prog_inc_not_zero() returns -ENOENT, so it would have changed
> >   the errno bpf_timer_set_callback() and bpf_wq_set_callback() report t=
o
> >   userspace (Sashiko).  No other changes from v3
> > v2: https://lore.kernel.org/all/20260915114240.3269184-1-puranjay@kerne=
l.org/
> > Changes in v3:
> > - Move the bpf_call_rcu_tasks_trace() verifier bits from patch 1 to
> >   patch 3; patch 1 alone emitted "resolve_btfids: unresolved symbol
> >   bpf_call_rcu_tasks_trace" (Sashiko)
> > - Poll the callback counter with an acquire load (Sashiko)
> > - teardown: v2 only checked that the program was eventually freed, whic=
h
> >   passes even if nothing was ever armed.  Also assert that the chain ra=
n,
> >   and read the -EPERM back through an independent .bss fd
> > - Use kern_sync_rcu() instead of open coding the grace-period wait
> > - Return -EBADF rather than -ENOENT when the calling program is going
> >   away, matching bpf_task_work_schedule()
> > - mismatch_map now pins the bpf_rcu_head label the new code emits; it
> >   passed with that branch removed.  Add a two_heads test, and wait for
> >   each grace period separately in the chain test
> > - Commit messages: correct the -EPERM parity claim, explain the inline
> >   callback state and the struct size, motivate the tasks trace flavour
> > v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay@kerne=
l.org/
> > Changes in v2:
> > - Rebase on bpf-next/master
> > - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
> > - Improve re-arming selftest to detect failure (Sashiko)
> >
> > BPF programs that manage their own objects have no way to run their own
> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> > free, but returning an index to an allocator or unpinning a resource
> > once readers are done has no equivalent.  sched_ext's BPF library works
> > around this today by pushing freed nodes onto a list and having a
> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> > BPF program to reclaim them; it is the first intended user.
> >
> > Add:
> >
> >         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> >                          int (*callback)(struct bpf_map *map, void *key=
,
> >                                          void *value));
> >
> > and bpf_call_rcu_tasks_trace(), same signature, which also waits for
> > sleepable programs.
> >
> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> > callback runs as callback(map, key, value) for the element it lives in
> > and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_ARRAY,
>
> Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily restrictive
> in practice? Do other APIs of similar kind have this limitation? E.g.,
> bpf_task_work_schedule() or timer, I don't think they limit user to
> just ARRAY maps, it's way too inflexible.

Right, bpf_timer and bpf_task_work take HASH/LRU_HASH/ARRAY. They can
because they can cancel: on element delete bpf_obj_free_fields() calls
bpf_task_work_cancel_and_free(), which reaches task_work_cancel(), so
a pending callback never runs against a recycled element.
A queued RCU callback cannot be cancelled. rcu_barrier() is the only
thing that waits for one, and it sleeps, so it is not callable from an
element delete. Array elements are never freed individually, which is
what makes it safe.

I can think of a complicated way to support hash maps but that would
need making the state dynamically allocated and finding a way to
cancel the callbacks. But I would do it as a follow-up if there is a
real use case.
