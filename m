Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E53F9F30
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120504; cv=pass; b=b1/mr9gwcIlR9LatwSdfbHSdBs+jbbo2ymYl9DGTkh/QyjC0XswhliWp+to61ZGkHh8nQRaxcIFRZaKks8al3nUFy7MZXXwHuxhcaRM6yu9q1aS6TKLF/3iZy8pZum0Tb5NGjy3qX2GBHIh+jJebWqyjkMB3ZtQZYkw+lO0Oqgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120504; c=relaxed/simple;
	bh=LgmwC15vBYlk9ivDchzBxv7ks018ccGDgJk8YDVvX/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jw8pwsSXoL+heFnEuLCgPRMuTbnYvHRDK3EzeVjKoZMn7dZcFYbRQWmPAok/Io9yeyMtFSZKnwwK/eChARVzcSFrztvXBYvwiUzfApo80CZDvenaHUqmMOVualKNW6lO5sqJ0RqIa7b327/aRqKXtZMSRzQvTWAOhPSs3bIZbao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jcz4XDUU; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcz4XDUU"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so282180a91.1
        for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 16:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790120495; cv=none;
        d=google.com; s=arc-20260327;
        b=JO5QNqbxTXc9UsSKlrtMIT2VzRYN2r7kbat3aCSmzxrKjMbFS1HASxxPG6wZ7rnBHj
         2lj5G/eiUFvuLpRC6xcRy5Vmh3YoA/cXCG4yAvrUJ34SststGoeNUDptHU8ds0chCwb+
         nt2A4ZJUbm8x0uTCdjRLcmvRqgpMziU0AynuMV42SawAh0cI680jLwVKNe9ktlls6EoO
         IWECUJAp7SUbrucT20igeUru1NlGa9IRTfHcgZnIA4SvnumQgHzefUJfRqGxqyM/RmXG
         uiYIU0zU8v6OZy13Yt8ubi2OnMroShLGKrpLG/jt4xgtsu+fYw6jrY77can6p9GhI5QQ
         2qEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SSGKQBsF6+JlfwR/lrpajT+hsQqdNsinALuZo7EPm4w=;
        fh=Qd/JmivLnzxETy/mSUAzn2y0ZCeXpYw4l6D1IO+X+7c=;
        b=IIEW107w0kKbZbNFduUBSPhqxtr06igXYfL/q6tl8UOysxdbOWLA5XlWtv7FXau2jO
         h52oFo6MDsBpL0GaSj/BgJtx2DQJDFT7+yvSOpz1wujbaxyKu3TYhzVYU6bQB1nFzYDw
         iP9CmWNOuu6cbs4K//dBs+pksif1BFew+guuQz6NldMCysMBh/gQyV1I9ahqKMpl+ToC
         kvY+0Vj2PtQzSqNp+tpkkKPdZbguP+KAnZtJU7fBXaGKep6IN4ihEXfp+e1bTF50GTg2
         szbwgm8TY0n+PZtNgoQKoJUAY1k7uUOmORdtHfc8Lfpq9caixgRpa/lOvGZ6ks/1isJJ
         xKxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790120495; x=1790725295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SSGKQBsF6+JlfwR/lrpajT+hsQqdNsinALuZo7EPm4w=;
        b=Jcz4XDUUYllB0AoMwet5CQgVZhabfAftaAXy0Ofyf4HYoq40VOn2SJIWRP1EZCauPq
         XI/7vKd7Cez022GLffvfPkPQUOvAmWKanGP3ICXyOYjNrIpNw8W1Cphd8Y0z58V/tLkl
         x6o5QYCdkLh5PydutZjEuWyT4QsLKZo6TZ4Lnu738pOuC3Zik/86BscKKlXPYyOQEOg1
         LzJN2uOZXXuRaORrpMrke5PFt07j+U9Rol7kpc4WNDhkbaxHk2gk8WW5spyfUQ45LnWx
         HYNvg8E4qJRXO82U/3nwWltO+ugT2NvL7XJRuZ8yW0JUoLmdy43n3v44AYoIZjEtpJ1e
         NOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790120495; x=1790725295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSGKQBsF6+JlfwR/lrpajT+hsQqdNsinALuZo7EPm4w=;
        b=fc6ppo1qsOxI/aPZkypttpRfujBckw9mY/G8Y3JcJsvYn2Nzf0c1pt01qMvf+NSX8N
         o6CjWTQ9MYFNLLkVv09nUy6+VBGu2j/f2DZGnmhAmFtbhaSx+MkTqwM8AZvt7n7q+YwE
         MF+jYYnoHHg5PcRUGPJ0yNeDuo7yZOloYsJTDquZd4nvx8shf4wsvwBBPk6H0OHYTFLv
         +FMfVaixTqaIfki/ev+fS2vb57odaEXIYUvbGY1KUzY1slFHlsbj9iHiX+SwM6LJtPD7
         3pbD/Xjm9QujB4XZgFcBHYe3SFYcH/zEuEHZDo1YIAp51mCHKF+QABtMsczBCZtA7FvT
         IrKg==
X-Forwarded-Encrypted: i=1; AKwUvBzyGmrQFSq7ULAWQPWGETz9+y1/tMdYtQlItHVxbQNxrINNpQWthor4oYXqs2qEmioHafE=@vger.kernel.org
X-Gm-Message-State: AFuF++laru+gFmNRxN8i06whILzrBUpYoE3VeDDQsSlAax+GqKwr4Xm3
	jqU/BJ546G4Y7yc8jzQ2Uk3n6ePENthfeDKWJQT+rTa2KOeL+t8bLiHQtAfyQ27c5Y8xIcvIsnp
	VL89kRB16WmVY+O1+SHRS1TFZ00An6oA=
X-Gm-Gg: AYBFou0ZAsSd3sVWIAemAAuTDQ/c0IUyuixj0l7iw/zHjQnQtsT1WqSIn0jMHe5OMyo
	B9fy/3uT8MXlefkQ4ovNGWJBU2wtblK7ogIeEY/LMYzFuLj2BpgRuT6Lf63lhHxO86gMYT4RJc8
	N8NOV5hwA7xcwuQT2Q+JXuLxzWW6k5chXwLMTH2qdNvwrWbvFHYtAKouHSSb58E7sEbQA9Akkt9
	UMpB8EFUFYpoEM6U7VUnztZCC4IPAHBxB9/1Hipule5c8vVAiOHeBU3J+ZWK44ED4nt+JT53D6i
	LYWjw5NH10gHD7421NjFZ7/VCdS181JEMx+GANuJTGqaWxMyN/idVh/UnG3mHEshd9rUOZKLtbi
	WhsAtaFaefIAfKeIZmbULnP38zRH7+siXKqMSXmtrK/b08KZ/LRdn
X-Received: by 2002:a17:90b:2f88:b0:39e:6a81:f349 with SMTP id
 98e67ed59e1d1-3a07e6bc44fmr832062a91.35.1790120494938; Tue, 22 Sep 2026
 16:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200208.3203834-1-puranjay@kernel.org>
In-Reply-To: <20260922200208.3203834-1-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Sep 2026 16:41:21 -0700
X-Gm-Features: AcwNN1UL6MHw4yUUzeJM0tpz093jYhI2Jx6fdz4PL4s0uMBzQuTPudOvINtyLu8
Message-ID: <CAEf4BzaifaWk+oHu-berWcKuS6Y5WfkcFTKZW-iMCPxG0=5i0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:02=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Changelog:
> v5: https://lore.kernel.org/all/20260921191407.1742386-1-puranjay@kernel.=
org/
> Changes in v6:
> - Size struct bpf_rcu_head at 48 bytes rather than 64, matching what the
>   inline state uses (Alexei)
> - Trim patch 1's changelog: drop the reasoning about possible future
>   layouts and about what the other async kfuncs return
> - Rebase on bpf-next/master
>
> v4: https://lore.kernel.org/all/20260915154248.3612028-1-puranjay@kernel.=
org/
> Changes in v5:
> - Rename the "hash_map" subtest to "bad_map" so that it matches its
>   helper test_call_rcu_bad_map() (bpf-ci)
> - Bump the callback counter after chain_err in the selftest callback.
>   Userspace polls that counter and then reads chain_err, so it could
>   still see the initial value before the re-arm had stored one, which
>   let the chain subtest's assertion pass without checking anything
> - Say in patch 1 why embedding struct rcu_head in a uapi struct is
>   acceptable here (Mykyta, Paul, Alexei)
> - Rebase on bpf-next/master
> v3: https://lore.kernel.org/all/20260915143640.36292-1-puranjay@kernel.or=
g/
> Changes in v4:
> - Drop an unrelated hunk in bpf_async_update_prog_callback() that turned
>   PTR_ERR(prog) into -EBADF.  That is the shared bpf_timer/bpf_wq path
>   and bpf_prog_inc_not_zero() returns -ENOENT, so it would have changed
>   the errno bpf_timer_set_callback() and bpf_wq_set_callback() report to
>   userspace (Sashiko).  No other changes from v3
> v2: https://lore.kernel.org/all/20260915114240.3269184-1-puranjay@kernel.=
org/
> Changes in v3:
> - Move the bpf_call_rcu_tasks_trace() verifier bits from patch 1 to
>   patch 3; patch 1 alone emitted "resolve_btfids: unresolved symbol
>   bpf_call_rcu_tasks_trace" (Sashiko)
> - Poll the callback counter with an acquire load (Sashiko)
> - teardown: v2 only checked that the program was eventually freed, which
>   passes even if nothing was ever armed.  Also assert that the chain ran,
>   and read the -EPERM back through an independent .bss fd
> - Use kern_sync_rcu() instead of open coding the grace-period wait
> - Return -EBADF rather than -ENOENT when the calling program is going
>   away, matching bpf_task_work_schedule()
> - mismatch_map now pins the bpf_rcu_head label the new code emits; it
>   passed with that branch removed.  Add a two_heads test, and wait for
>   each grace period separately in the chain test
> - Commit messages: correct the -EPERM parity claim, explain the inline
>   callback state and the struct size, motivate the tasks trace flavour
> v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay@kernel.=
org/
> Changes in v2:
> - Rebase on bpf-next/master
> - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
> - Improve re-arming selftest to detect failure (Sashiko)
>
> BPF programs that manage their own objects have no way to run their own
> logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> free, but returning an index to an allocator or unpinning a resource
> once readers are done has no equivalent.  sched_ext's BPF library works
> around this today by pushing freed nodes onto a list and having a
> userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> BPF program to reclaim them; it is the first intended user.
>
> Add:
>
>         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
>                          int (*callback)(struct bpf_map *map, void *key,
>                                          void *value));
>
> and bpf_call_rcu_tasks_trace(), same signature, which also waits for
> sleepable programs.
>
> @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> callback runs as callback(map, key, value) for the element it lives in
> and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_ARRAY,

Isn't restricting this to BPF_MAP_TYPE_ARRAY unnecessarily restrictive
in practice? Do other APIs of similar kind have this limitation? E.g.,
bpf_task_work_schedule() or timer, I don't think they limit user to
just ARRAY maps, it's way too inflexible.

> and arming holds a reference on the calling program until the callback
> has run.  Patch 1 covers the lifetime rules.
>
> This needs
>
>   https://lore.kernel.org/all/20260810122758.183765-1-puranjay@kernel.org=
/
>
> for call_rcu() and call_srcu() to be safe from the contexts a BPF
> program can be called in.
>
> Puranjay Mohan (4):
>   bpf: Add bpf_call_rcu() kfunc
>   selftests/bpf: Add tests for bpf_call_rcu()
>   bpf: Add bpf_call_rcu_tasks_trace() kfunc
>   selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
>
>  include/linux/bpf.h                           |  10 +
>  include/uapi/linux/bpf.h                      |   4 +
>  kernel/bpf/btf.c                              |   7 +
>  kernel/bpf/helpers.c                          | 102 +++++++
>  kernel/bpf/map_in_map.c                       |   4 +
>  kernel/bpf/map_iter.c                         |   6 +
>  kernel/bpf/syscall.c                          |  11 +-
>  kernel/bpf/verifier.c                         |  84 +++++-
>  tools/include/uapi/linux/bpf.h                |   4 +
>  .../selftests/bpf/prog_tests/call_rcu.c       | 275 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/call_rcu.c  | 110 +++++++
>  .../selftests/bpf/progs/call_rcu_fail.c       | 114 ++++++++
>  12 files changed, 728 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
>  create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
>  create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c
>
>
> base-commit: 79dc258c9392051420a26f1504c647bd3d27c66a
> --
> 2.53.0-Meta
>
