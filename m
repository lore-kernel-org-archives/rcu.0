Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423157;
	b=Qik8gXDWeDsyJbSvg81ItlcMxz7Bgc9sD+ZEDmpW0BWw0OgURV7I4gLdAIrfDO7amAFj
	 JiVg+K0e7JW/6zBwdI5T3AFRvTR3dYDIUCA6Qvl5z+7fgPVlQwFaGWmKkQkk1jIvZ7cqp
	 SnTWELRXgAluxnkQJWmB62cBWv8my8afyqVvtsZvz8j7ZUoqBWBFOHglPQcqKRfeeNxCZ
	 XDY372ZQ3rmB/z20NngGqpzGwCruIzfr6gmJsGVgmw5PD3YOI48Gpw8hA+fwwKohZpOI1
	 5zbmm+GZwvHIbiTYSmFbcVqkewSt15mJv8oDF+oKOgh2QuX/SRaHWQ6Zgho6P44eqqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423157;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=dbShqUjA5wVrzgbzop8vkQYwagKJzMARcf5XNW3OE4Q=;
	b=4nOf9rEcEpc2+glmWIYdS8pbxG1oSYBZaBvAELAgTqHVa/CeRavFla6y1OeE98SdBbd7
	 D8QjbiqP8wkA48ZQK53YXLhbwjcWbK7EA/KafZXiG0ROhaoH4ST7JTCrMgxjWwuzR4xA4
	 ikqwEDm78K9XgWp1zIJ8v2wHG5QP5Pj9HlUfPrg4HGMtQcEZZTJDFEvynFQOi7drDxMHo
	 nKLq3b8Jqm72SvVgfx5pIV6oPdUIkc54C1U3p4luHLv0rarvM7oqm4CGvFZ020A3J5Oj1
	 KB00KW5dpa9uuvYceiXkNh+AG5++Ppwn+NbbM+oUrieOrBYTDb0nYQPq8AMjG81cjNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUTEGRhH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37D606A334;
	Wed, 11 Nov 2026 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUTEGRhH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82C71F00A06;
	Wed, 11 Nov 2026 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423157;
	bh=dbShqUjA5wVrzgbzop8vkQYwagKJzMARcf5XNW3OE4Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=AUTEGRhHkpvOErUt0taSvplWLN9tN89l/e4Yzd4Zo5TVf4nxRi6Z+VH3WbcOa1cOz
	 Drtl0CLFHkWS01Cj9Yhuz8VmagZa7o8NDv8LBm/JQE9o240diNyE4YmOgJAg0SMct7
	 AUEHiThNya/Fu9HDcpGvsqr7cYCSnZzuGHmHNJ7kOZJrwX5JyKVnKyIiWzxxVRi/au
	 jc7QBpe2+pQVcR1BeInkZIRaV+a+VHuymf2lvIG0fX3qCAAnJAhcvrd55cfQCPOgOT
	 VxrcXLAzGZtgbHquRt9RO51LGqeLkd8VYHdvQqI5dwraMCkLlOq9SBEjx0kXHGFeJR
	 Ev01UgwZYOFgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 855A6CE0840; Wed, 11 Nov 2026 10:52:37 -0800 (PST)
Date: Wed, 11 Nov 2026 10:52:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Song Liu <song@kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"leitao@debian.org" <leitao@debian.org>,
	"david.dai@linux.dev" <david.dai@linux.dev>
Subject: Re: [PATCH] rcu-tasks: Use pr_debug() for callback contend/collapse
 messages
Message-ID: <94f4f310-63f2-4964-bca3-e1756901d33a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261111053551.3367903-1-song@kernel.org>
 <20261111155441.GA1829883@joelbox>
 <CAPhsuW6_WsuabPQ6unancwouSPZStQQZa8WoDG82-n6Bi5gPhg@mail.gmail.com>
 <A0F1CA65-00B4-4E42-8CB8-12C11BE7A7A2@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A0F1CA65-00B4-4E42-8CB8-12C11BE7A7A2@nvidia.com>

On Wed, Nov 11, 2026 at 06:22:21PM +0000, Joel Fernandes wrote:
> 
> 
> > On Nov 11, 2026, at 12:32 PM, Song Liu <song@kernel.org> wrote:
> > 
> > ﻿On Wed, Nov 11, 2026 at 7:54 AM Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >> 
> >>> On Tue, Nov 10, 2026 at 09:35:51PM -0800, Song Liu wrote:
> >>> Commit 5de907d24919 ("rcu-tasks: Disable callback contend/collapse
> >>> messages by default") added the rcupdate.rcu_task_collapse_debug module
> >>> parameter to gate the three pr_info() messages that report RCU Tasks
> >>> switching between CPU-0 and per-CPU callback queuing.
> >>> 
> >>> The kernel already has a mechanism for debug-only messages that are off
> >>> by default: pr_debug().  Use pr_debug() for these messages, and remove
> >>> the rcu_task_collapse_debug module parameter, its documentation, and
> >>> its boot-time announcement.
> >>> 
> >>> The messages stay off by default.  On CONFIG_DYNAMIC_DEBUG=y kernels,
> >>> they can be enabled at boot with:
> >>> 
> >>>  dyndbg="file kernel/rcu/tasks.h +p"
> >>> 
> >>> or at runtime with:
> >>> 
> >>>  echo 'file kernel/rcu/tasks.h +p' > /proc/dynamic_debug/control
> >>> 
> >>> Assisted-by: Claude:claude-opus-5
> >>> Signed-off-by: Song Liu <song@kernel.org>
> >> 
> >> Makes sense to me,
> >> 
> >> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> 
> >> Will apply for 7.5.
> > 
> > How about we queue this for 7.4, say rc3 or rc4.
> > 
> > If we delay until 7.5, 7.4 kernel will be the only one that has
> > rcupdate.rcu_task_collapse_debug. IOW, if we merge it to 7.4,
> > no official kernel will have rcupdate.rcu_task_collapse_debug
> > at all.
> > 
> > WDYT?
> 
> That works for me, Paul shall I send this one separately for the -rc? Also appreciate an Reviewed by tag from your side.

I sent the Reviewed-by directly in response to Song's patch, and I would
be happy for you to send the pull request.  ;-)

							Thanx, Paul
