Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D23B3BFE
	for <rcu@vger.kernel.org>; Thu, 17 Sep 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662931; cv=none; b=b2RgdI/nHu5PwdG8ipy6sDsg9YOMq5ts9Lf7DflFEZ9fUeWnbPOM7F51moYSOL0AKNDm63yLIdjuXODgXq3Zl2HfFu00EflMoLFdRdV/1E2sedM7+LhSc2h4y98ZWpv/SdPtw0+Lbg90xmcaQAG1RC9B/Xc6E/2UI/NZEwGZp78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662931; c=relaxed/simple;
	bh=QgmhQmszRFG/vfc4SQJB1/3XDJxm8LGwggD6bEqDTmg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnZUSfX7u/I33+/OUeXxOOlk5axGZOIM2zNx8LdGZFms8uN1T9Brgrd/EFKvKnoUJNRGKSxtAQYpXX8cbkVXRbLrNhVt6wkXl2ROGI/gDeJi+c3jNH/KEV95IS4pn7E1YZBjZ7irdJYKSSq68ks1DQqZaKfT8qCM1Z9cvHeqZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=LuM51xkz; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="LuM51xkz"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76c9deeso13201231cf.1
        for <rcu@vger.kernel.org>; Thu, 17 Sep 2026 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789662929; x=1790267729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BF23L7IjgM1pfHyM3ghg4jPhGbV/DtVtyTw2lo+n/XU=;
        b=LuM51xkzmAaOcyQO6PRPefCD2IUxYQT6stDb8ZVHLROTPhEUuc2vBl4F86rmGvBLPm
         D9gDj94gfkeOQ8qx3DosrHXRPdS9mtpAzG07684+KfGg4N9ucRAuw0bpthVZkojarv0b
         sJsMFZXDCEAgJvBZRBiu0kkMv9HtohKo2yc7z5TfhWdj4BStarX6VUMcJpc3ocvi43s4
         2a+ot/MLV2YnufdCKmIczlWJ+sAlTm23mkavayZtNtHNuiIkH8Ol/7WNRpf4lLwz3BUo
         4LKiQZ4lhAKDfF1efbEIUq1y6ElZII3YzpkzqF2cLv8D926TqKlVlL7qf+ird7QcS6wd
         eAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662929; x=1790267729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BF23L7IjgM1pfHyM3ghg4jPhGbV/DtVtyTw2lo+n/XU=;
        b=L21jGrdXM0rYPg9e37aW01vkLEM627QP/kjsYJgJRob1z0u71k+WHZRXiLONRVqTJi
         EiXya4zfjSzuU/8+NT47xOTvRrAa9ZDqqf2MJwKKhEA5O9m32eKCJqJcIjRC0dJL1BCJ
         ClCaAkldZysBSsxgJ661gDooAwAjhhqtFjEosbiLqZ4zje9zDXuK8d/jQguns0/uUo8a
         g0bWZmhpdrxRBX2hG6946Lj5QyfIGhxEAVSF6oqkO5u5BlZ2fGn+jlcQhfJr72jgxnnI
         UWd/ZRjtl8FABkZ7JREourKny+Wp9ptly2Akx27bdtWzD/JO9mCi6RvToHJ8OumvLDUZ
         IKXw==
X-Forwarded-Encrypted: i=1; AKwUvBxxCMHlpe60bOOqp6K7gGi/K1LeNxt371tz7zHA5vTXp19MVlsIAEUc/S3MBlyHnvNqrWU=@vger.kernel.org
X-Gm-Message-State: AFuF++nK8N5o5bDUdHO6Ov+ab7yhZqKrmFhVCcjqKDG6SaWYwSI3iOyn
	k94KqMV3hugi/JnqPlRFKPFbGp5NqOKTtIqdiss47ass18F5IuYSxTBdLV9RKUaCPLk=
X-Gm-Gg: AYBFou1onRMMKmmQ/w+P72QNgYflmdWxyZNUZAsVpaMxSR4eQcaqqnVKH/5sJNxeigh
	WKqanitMIRvJO5nvaNLul+iIDd/pDHEB/yzVtafRzuTihYB7yTq2OqhHhzyxeo2DOgBjIS1WprD
	39Z+NWPMwt2qkKa4RO9VbRv2w5Z5Xv4NvRmXaIpWkH4g6OC1uomuDcVlEI/Pc2w9XMyWGxtE9tf
	5vawVlSDOCLnnVYTPrQopCcGkikwq3xIGJ1yHdZeXZWV9hoVQ/GtPyetld8rlIgcIU8byyuyExk
	o9boD18rlfk4ax3BzSZxiplAonFUSgfBjzzXRCh4WNTd0Cf8FuDbGVBtmxJRKeif0ofyc1N/K0g
	4WUbeYClOAvc+964Of5uGDhRgz+7sxG5zyykc1oU4i/pupMd5BkXYXD8wt26skLcmkyyDSJOQs9
	peuQKGwU8v3ormKKirfvVXUXf1gnuBpvsZrPymHnPlRgPE9l23LBBI24iec/4i8C+vEuOm+ZDhP
	Z92UeWyz7aJSw5vUzIhwKHb1gAKMqGdQvZ+37YFvshz8BWQHhIds2VX
X-Received: by 2002:a05:622a:1ba0:b0:530:b2e1:2f3b with SMTP id d75a77b69052e-5329b61d526mr11929121cf.50.1789662928648;
        Thu, 17 Sep 2026 09:35:28 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5326208ea78sm56756741cf.24.2026.09.17.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:35:27 -0700 (PDT)
Date: Thu, 17 Sep 2026 16:35:19 +0000
Message-ID: <c51591e0e96c837bcd762c207e5e1869.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Andy Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines
In-Reply-To: <8fea176a-0ca0-4a70-8cf9-8240a22359e4@paulmck-laptop>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com> <aqlgxKGk_AEKls_1@localhost.localdomain> <edc7cca2-a5c5-455c-8969-ea05dbdb08f7@paulmck-laptop> <aqqONH8flTIpOUqT@localhost.localdomain> <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop> <aqqpRoTfywUuTgoC@localhost.localdomain> <aqqsAUVV8a1yrQzX@localhost.localdomain> <6afb0afe-e7b8-46b4-9fea-2c7cf4791044@paulmck-laptop> <aqq0cwvRDsorGwgc@localhost.localdomain> <8b73e1b3-0580-4ba9-b2e0-6363e429808d@paulmck-laptop> <aqvZwfUVsiEI7q7y@localhost.localdomain> <8fea176a-0ca0-4a70-8cf9-8240a22359e4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 08:40:10 -0700, Paul E. McKenney wrote:
> On Thu, Sep 17, 2026 at 02:14:57PM +0200, Frederic Weisbecker wrote:
> > You're right. So we'll indeed need to reuse the deferred qs points here.
>
> Except this is getting a bit involved.
>
> Don't get me wrong, if Josef is happy to take this on, far be it from me
> to stand in his way.  But if not, we should be willing to treat this
> optimization as a follow-on effort, whether by Josef or someone else.

Follow-on works for me. For what it's worth 03/13 is already fairly
close to what Frederic describes, just outside the core flavor: no
task-list scan (the GP waits per CPU for a pass through __schedule() or
an EQS), the irq-exit preemption path checks the interrupted IP and
queues the task as a holdout before the switch, and the holdout is keyed
on where the task was interrupted so nothing is needed from the
trampoline tail. Moving that IP check into the tick / rcu_exp_handler() /
deferred-QS paths and reusing the blocked-tasks list is something I'm
happy to look at once this has settled.

v4 will pick up Alexei's ask (reader emitted by the BPF JIT around the
fentry and fexit regions rather than in the glue) and the idle-CPU hole
Sashiko found.

Thanks,

Josef
