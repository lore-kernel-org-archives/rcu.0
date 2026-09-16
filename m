Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6D3815DF
	for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789530320; cv=none; b=Rez834o0xWyIx+HD7VOfDshUjl1xhIgt3aPbe36ynnFvENgyjk2MQaG6R4F2DZqevZYMTt0neoToZ+ATnQeTU0qwNdy/SwFXiKR3eGbUIQOVTe7LDkBP4gkzjBG91cQJ/D2UW5j627FeVosl5IWWwhOBLS+Sunxdkn1mpWzlaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789530320; c=relaxed/simple;
	bh=684D7Flb8NHS/K5FyLvOJG51In7MM0mpezyufLZNn90=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mB+Iy2GZgrMhxK6FsOVIoBj0AErn2+YsqL/c20ibjCNnZU4v9n/wZl+TICQvg3nuNm/bygGQuQijDnc2wO3/4dPAF+9GueJ69V66NysjuviG0QBYQfSjZB4CkY5J34vVl79wKAuHSMIJF1pYcSINw0K6XFBkQMNURRmFZ55h8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohEoxmT2; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohEoxmT2"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso121475a91.0
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789530318; x=1790135118; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ukRQUFxBTM3YxkUDVCzWjtsHOmDoo6m23BhwxAxqqWs=;
        b=ohEoxmT2BhacRcadblywH5fnmx0gUZr46YdwcXs7QRojAWyzDz3ux+HVGjzqyPTN4U
         g6cgwvB06k6IowNoWHQpgZF3aktD1dwAa8oYyS5lNXp6jkvh+TKeVX2NkLROEv+j9tm6
         aaHYJyKvD3i/jHj4M6M/28SXdzUceRNDYoMa/rBK+vWj9lWeqKCpWc2K5mHCxm64DA73
         5XAKWCPKhzw20rdn7YYOcKw3D2WSBrgYheTktd2isJMymJ2tVG+LCDWrhj6NffHlnEtT
         cOBGSfPBeboMfxhgVBuPY7qSJveTuCGtku584TEbCCkwEhL5/L2rhnM0LricbN2QooYN
         FjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789530318; x=1790135118;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukRQUFxBTM3YxkUDVCzWjtsHOmDoo6m23BhwxAxqqWs=;
        b=TwDrdHsB76CRXCqVj1eM7S69wQFzBSuLEN5SZywkOqe/XZOUIhjPiC/dccN3y9a+0N
         rf5rty4U4owGmTynT8d0Mwre8hk/DZCMRAOf6ktvgPdC5SBMewm+cRI0qhUXnwvzbgxE
         g2gF2gCc/Y/E2GU07LNp/NWD/6q+oNvGTh67J4gw7dSPjcs6+mEy+RHa4+YI9pB1DHa5
         LBUwCQZsweXZ7gWLqQXY/wNtjErtm7GB5KztjDKMa4PtVy/TdXaFjl8hTakbttY9OsNH
         X9IZy5VT43gsB4H0PgUR9kW9/gR1F3ZA5jbEuii3LTgWXO3dUHToN6QEepiMbX90Njdj
         0Ufg==
X-Forwarded-Encrypted: i=1; AKwUvByjH2NFY31Bh1LhTbqGnQHaGpJgeg1fKh5+xLMcH4D+1qWfView0NKZ9Xx+aPS8Qo0pqGk=@vger.kernel.org
X-Gm-Message-State: AFuF++mL9rHOOfv7KXp7WTQK1ie1PoJJXsqN0NHwr3r/FMODSKfFILRk
	vWoLzhXOvFsee+jqhSJOR8eS6yxWrY78fjZqzz9n17V60GHUbPDnsnNe
X-Gm-Gg: AYBFou1wk8/4SkJZ5ichlDpuBIeTa2qKtGHAE3JpH0VaB97/SF7xGvn4YzglLyoa42e
	TUzPj5OdJOsKEV0JogHO4udwZC8/eum2LM4/6y9TgLLLNtlY4C8s4pmQQR6/R/Gnp9E8GFn9iKb
	TbFQI795AwnntnJQQA0hUh+T8rc9DTjE3WElkZPBb0qiGcQtTfHwWXRzI1T7DhT9VacpNjl0kDT
	uEKXs5gs/8WNGpePlGGzZ+USoJPFBB/oy6KqRy5WdqYXjzn0KSKex9LnN3de2RTh/4B0Llx2/Wm
	c5MlzE5Us7FxB1XS+gUg72B2Z4m0DuKIjadZ/bXKMB1QhGGzE0ZLbbMvMA9rJg4128YdfR61tW9
	b4k6ta/Pmow0FPwVE80yr+2I3eJf1b9JVbHLcguUt1gUeYJ5ptomVx8XJIPRU4DSYUygAnjM7PQ
	EPnlNqykzwD6ls2dYnEopU+8pHt223hC28l6G+vFe5CSbM0hyNJJSC0EawVH8FREiyqt0p7Q437
	/IdwfRIPBjsDIVHa5fq/mCC/d9PtbJSbc1vcnuoq04rneCNvRLD/217ROBSMoFaNLbjIDyfVxzO
	3yWES30nUr/8DY2ht4+PrdTZ9Q6NjRLSrKgXd7Zdd2JtLV85eAhZ00uV484CEZFZBdI=
X-Received: by 2002:a17:90b:2f06:b0:39d:b57e:b47d with SMTP id 98e67ed59e1d1-39e1ff96302mr969180a91.8.1789530318064;
        Tue, 15 Sep 2026 20:45:18 -0700 (PDT)
Received: from localhost (ec2-35-83-186-167.us-west-2.compute.amazonaws.com. [35.83.186.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bba0696sm1902898a91.7.2026.09.15.20.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 20:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 03:45:16 +0000
Message-Id: <DLGFJY2ZSY5M.11K7HK2CLM6I9@gmail.com>
Cc: "Andy Lutomirski" <luto@kernel.org>, "Josh Triplett"
 <josh@joshtriplett.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Juergen Gross"
 <jgross@suse.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>, "Andy Lutomirski" <luto@kernel.org>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>,
 "Juergen Gross" <jgross@suse.com>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC v3 06/13] bpf: Take a Tasks Trace reader in the
 trampoline glue
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Josef Bacik" <josef@toxicpanda.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <x86@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <x86@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>
X-Mailer: aerc 0.17.0
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com>

On Tue Sep 15, 2026 at 1:17 PM UTC, Josef Bacik wrote:
> +static __always_inline void bpf_tramp_read_lock_trace(void)
> +{
> +	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> +		rcu_read_lock_trace();
> +}
> +
> +static __always_inline void bpf_tramp_read_unlock_trace(void)
> +{
> +	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
> +		rcu_read_unlock_trace();
> +}
> +
> +static u64 notrace __rcu_trampoline
> +__bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *=
run_ctx)
>  	__acquires(RCU)
>  {
> +	bpf_tramp_read_lock_trace();
>  	rcu_read_lock_dont_migrate();

This is double increment. rcu_read_lock_dont_migrate() includes
rcu_read_lock_trace().

