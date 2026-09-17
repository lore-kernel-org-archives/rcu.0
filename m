Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E513776B
	for <rcu@vger.kernel.org>; Thu, 17 Sep 2026 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611867; cv=none; b=Hhdkacq2q9it0t4iD0WZdtbyehFDGOMPVC8TvnuWZoP9RhNgHWNBdPiRTeFTLxWAVEy8MEf7nZihsSUiiknIgXNr0TzrkwJjEKkbm+FA/dwul1P7hK5/dpXwolbSrXJ/0IAFpOgLl4c6+T1V1NwtWvUPAywazmcTWFRisn+3DNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611867; c=relaxed/simple;
	bh=E+msnkVkMuv7EW3/XyJSZb0DiTqaEOW4e8lxU2bUdDk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=WHtlHNkGHPbNUhMXtVI0BBEnKP8ObdBpjXBXeiYhwATyu0orihaKiUyqtCFSAVJrsxFEkESwawtAWWiLfIlEbZbNoZAK4hSskQEQkzyDcXZ81REZwe1dp9Ge7W+cYfFTrTLtpRPeAsIqTFKtKxsh3iWnuqx6jIhJN83UavYgrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfozeCmU; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfozeCmU"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso3511925ad.2
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789611865; x=1790216665; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6EKmqByiGxzJPh+0Mll6vjXYdVK/vy8pIRVPNPfe0KQ=;
        b=DfozeCmU42c3ZQt6zeu2eLYJawKiY6mKFmktJGlatz7kS0KtK38o/GFcK0d5SnwSzg
         Mjdec2QO6eboPe2Jz4IkKLjF/iIv0aBkjdGl8vvrUkCEtctay+UHUKqR9DVS+y+KVpob
         tncm79dXTOTPcDu9g9fjUDBbfMrrWN2AQ9kgDGSwv2d3BckJdz4kWNueJQrwT2QE+PI7
         EH8vqv5Tjnq6dBxaNOQhZeBpEqZcgXhQglEoY7nbKJDPfzEdiS0Zrafzhhq6OdQYBxWH
         dbUC21FZJB4V4N6W5UsLx6JZ1N41Q/dd4w4rYK3UVq+xlao0i/8nLQZPfdyxgebsGQDe
         YxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789611865; x=1790216665;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EKmqByiGxzJPh+0Mll6vjXYdVK/vy8pIRVPNPfe0KQ=;
        b=JfYpsmjXjaFsBv3rxbK+3p3lNHAFBKlXRtyxD3Rg9gqiBSqVnq2Nakte5h0dhX4fX8
         R9jIC7HJEWq8JCrZL+gEE1pdgn+1BQx6Lay7ph9nS7zBk6OAwjbXSHOTHn0wdbw2m49w
         UUFx94JtYhkW7ffM+5YENtg2Fn1ZtOAp5y8R1gulrjJSruH0PH+WtEYfzIRiMKmhG+eN
         CVHQOq3sAW3bZrsyvj7GE1FzRbo4F43T1R786uFjDumWLwcggQUcr3XhWgPvENa/1T59
         b0F8KibUB7bd7GcJ15yMGpFYwtpY3NrUf9+g/FZG37VJBAXgoua9wZb3e4LAqmLNWP7V
         3u8w==
X-Forwarded-Encrypted: i=1; AKwUvBwczD/sOCOVdrZ0hcl0kpE6GQz+/pnPCQaQzq6R9nQPSJc6Y32tB6dfZRD4TWjk4+BHZbo=@vger.kernel.org
X-Gm-Message-State: AFuF++ncvXZvH6JkblRF8avMhfC2igfsvQMp5buwsQm+vmvke8rbQDa1
	RTSMaqq7XkIigHaPK4MHybpirzhh67KUGVbrt4mdDrBrje+ej6ZfTK2b
X-Gm-Gg: AYBFou3p/jlqf+G2VIvSYcHsC7UJGsRwhfU/sj8Bu2xhnk5Jzlen+BhS8go4TFD4nHN
	80+uKbMHm4CIhifPzKbn0jBhAyvZOb/kXECaoFrWhu6RhXM/pFYwTOkrVmTTuD7ShoBhxfHRHf3
	YmHtbP5Wgx8jQd0EWZ+xUQ2kQ8awZU4B4Q4LCjc1r6dLwFqqyLviKZ1LqjIvtq1TO2bFx0ckNgX
	yOw6TcQDmJMN4iurMMJpw+j3FBeRGovwwswLuoNFfqbHicScFmU+SeVH7nX0OUTdqdIL/OztfF4
	qWmKWvUY9dhiLOmy/Zc2FhyOoU0P+ZMTRgotUXmxJDVhdrMlkpIrmsAQd2xoSNGR/kZcZ+fb79I
	4clANqXjSwFoACrySck7jBJ2jbhyQ9+apKLIGumVSdbHfJsQhTmrOLiO07xS0KiHzG1FZb09zOC
	tJirfteFXsduUnYOp+ITedQMfB7jkrIyIAbstWuZpeTQzW5yPUZwx+TYMy5pnw556+roAROBLCV
	8ti6uBdXyyyxmeARoRMtk3UK+wlJXheotBqIe5PmL4x8NA+pvSnubLruynIhr+nxDUyDHKkS1PB
	HUp0
X-Received: by 2002:a17:903:1ac7:b0:2dd:60d:8b7c with SMTP id d9443c01a7336-2dd8e3f57f8mr114351815ad.13.1789611865419;
        Wed, 16 Sep 2026 19:24:25 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89ee3557sm18694235ad.52.2026.09.16.19.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 19:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 02:24:24 +0000
Message-Id: <DLH8GKM4B06Y.3HTSEM5YGFR5D@gmail.com>
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, <x86@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Juergen Gross" <jgross@suse.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC v3 06/13] bpf: Take a Tasks Trace reader in the
 trampoline glue
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com> <DLGFJY2ZSY5M.11K7HK2CLM6I9@gmail.com> <a51c15af0d61414aa780e7646b8e74cd.josef@toxicpanda.com>
In-Reply-To: <a51c15af0d61414aa780e7646b8e74cd.josef@toxicpanda.com>

On Thu Sep 17, 2026 at 1:16 AM UTC, Josef Bacik wrote:
> On Wed, 16 Sep 2026 03:45:16 +0000, Alexei Starovoitov wrote:
> > On Tue Sep 15, 2026 at 1:17 PM UTC, Josef Bacik wrote:
> > >  	__acquires(RCU)
> > >  {
> > > +	bpf_tramp_read_lock_trace();
> > >  	rcu_read_lock_dont_migrate();
> >
> > This is double increment. rcu_read_lock_dont_migrate() includes
> > rcu_read_lock_trace().
>
> Unless I'm looking at the wrong tree it doesn't, on Linus' master and on
> bpf-next it is
>
> 	static __always_inline void rcu_read_lock_dont_migrate(void)
> 	{
> 		if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> 			migrate_disable();
> 		rcu_read_lock();
> 	}
>
> so plain RCU plus migrate_disable(), no Tasks Trace reader. That is why
> the non-sleepable glue needs one added here: on these architectures the
> trampoline image the glue returns into is only kept alive by Tasks RCU
> while the task is a rcu_read_lock_trace() reader, and rcu_read_lock()
> does not give us that.

Right. I got confused. Since rcu_read_lock_trace() CS will cover
both sleepable and non-sleepable prog types let's do it once
per fentry+fmod_ret region and 2nd time for fexit region.

We probably don't want to hold it for the whole trampoline,
since orig_call will delay freeing of progs.
