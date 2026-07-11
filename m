Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2C379C21
	for <rcu@vger.kernel.org>; Sat, 11 Jul 2026 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783774998; cv=none; b=UHj6W4ZAq4NSISbG/0e5AkROIcbbBI8p3xYe1U/MD9b68L/LtZ4rRyh8QV03o3HKaZQqhcC2xmdhEhzN4xUGQfXP6ZO5EJ6ixn5duP1zHo1yVbGrhmJ4NmbgjYyTPUisyVG8DG5/XLFirp1LbzpOBJNuuyYDnRPy/9s9GJlisls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783774998; c=relaxed/simple;
	bh=Uvf14jRvuJ1O3eHThoDT9f+Un6LPNgJ6LTmsd8EcjdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs1Q9cttAza25L/b5bNttIv2nwn2k8wS/tasse9iNDWmuKySipoEyeGcHzwpxeGqWO3VvyrAkwhlt+MYrhDsptrbnAJRcneNr5AoxQQmOKFAbqSy53UetJpVfV2MB3qRPKsgGeJ543LEFCGS/TMxSgr4iXQlWEVj8Crc/kQJ2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnzZG2uu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnzZG2uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783774996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFpBP/DfDzpcxl3K+IjgP1qlssgGkcilk5K5TKskscE=;
	b=ZnzZG2uuIbNL+D2hM+Piin1aXWcm1+D3+TP/8ndyHhJSA3OBLE9uWY+llEZ3eikmfc3dQZ
	wD6MWUj4W8vNwGbV6/hHLvA3nBssJmK0vmO3AtAFhN0miNL+ifh/R7l0tAX89zUidcgjaa
	UqifGdslJfNKYRkHt7+eXOsQIZtbCSg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-gmpZbOxONLaxakcC-SZQqg-1; Sat,
 11 Jul 2026 09:03:13 -0400
X-MC-Unique: gmpZbOxONLaxakcC-SZQqg-1
X-Mimecast-MFC-AGG-ID: gmpZbOxONLaxakcC-SZQqg_1783774990
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74BFE18009CA;
	Sat, 11 Jul 2026 13:03:09 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8F30B1800598;
	Sat, 11 Jul 2026 13:03:00 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 11 Jul 2026 15:03:08 +0200 (CEST)
Date: Sat, 11 Jul 2026 15:02:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] srcu: Add lock guard for srcu_fast_updown
 flavor
Message-ID: <alI_Ajs6q65m8MNT@redhat.com>
References: <20260706172744.3920417-1-puranjay@kernel.org>
 <20260706172744.3920417-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706172744.3920417-2-puranjay@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/06, Puranjay Mohan wrote:
>
> Add a guard(srcu_fast_updown) definition for scoped
> SRCU-fast-updown read-side critical sections, following the
> existing pattern of guard(srcu) and guard(srcu_fast).
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/srcu.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index a54ce9e808b92..72c86d3b23f2e 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -638,4 +638,11 @@ DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
>  DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
>  #define class_srcu_fast_notrace_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, _T)
>
> +DEFINE_LOCK_GUARD_1(srcu_fast_updown, struct srcu_struct,
> +		    _T->scp = srcu_read_lock_fast_updown(_T->lock),
> +		    srcu_read_unlock_fast_updown(_T->lock, _T->scp),
> +		    struct srcu_ctr __percpu *scp)
> +DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast_updown, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
> +#define class_srcu_fast_updown_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast_updown, _T)

Looks "obviously correct" to me. FWIW,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

