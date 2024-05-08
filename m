Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD784D3D
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176893; cv=none; b=s/tAE+0SR17AOq9cf0w9zhQlAoiEywx6xWQvOC0GgEZC9lJn3JTACKBbDcKnKkJSMdKSglvXH+DapyfPeRfluD1Dd+T1PZ/hX1zl1OD6saAjm9tofKYYjY2IIPRBaxgl20isxUViQfapt/3sCw3jt2jJkLg96A3UZwg+e844ypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176893; c=relaxed/simple;
	bh=fKHtQmZwtVbaMapGWWdAwFR8INwOLeokQNWFm78CXHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcgMpbpf1oOocEXq4S7AmlItUqxunbH9yqruBzNG0XKIGYDzdy3ZVacHzALFOqhzpKyuswhq9tQhoEEI+oVPSa0AePTXO6CHSs96s2nXyz9jYYQ5w7rv7k52ORyomwz8ArXsLGI5Y2B9RSI021UcEI4GuUhxSb4CesuMtVVTvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9z3sYqm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9z3sYqm"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60321ce6cso8141699276.1
        for <rcu@vger.kernel.org>; Wed, 08 May 2024 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715176891; x=1715781691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRuBCygsQV/Xuf9mbwBl3CtdhKC/i9RdJrSQbVnsUa8=;
        b=K9z3sYqmIAcHmmqwZ8w2pCGQNSHewbBZJPfo57Brqx64hGrDQTetoK56WpzAqxuDXT
         ICNgkMVGre1i31bqMBcdbeEM+iIyUJ4BUAC31Vmv9MYR28qCUBJJV7QnSUWminXbjdCP
         VpJ/Yhm9F8BVIbT4JpQj4WYeF2E7gHft+8lRSPOLf8dzN1QJJVEOIN5uMTYKiVuWze7J
         xrptcS4kS8SDK96VpenkBl3M+2nP1ARUdc9r7BJOlWdXTG9nI1qftm4fwOF5bvKxGox7
         e9q+QITdjKs8AIKVG6h1uBRiBQwOfUfvuvhOTQYOZfJVNwEueFMDr+ydQ5cNrZBVuYad
         mBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715176891; x=1715781691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRuBCygsQV/Xuf9mbwBl3CtdhKC/i9RdJrSQbVnsUa8=;
        b=Fc+Rq1C3tbzVWTiUmTxdkLE6QeN4sl3sZggycvs2JfErDZgkeLn50S4xgOlBF9Pk+8
         PsZ1iQtsHq6ceDwT7pL+U94WDKgbKkjPjDo/NNZzhRf3BF4Mq/0lCr+/54q1NKkULqZX
         feQlYwRvTIeCah1qIsLw2SGqHr5JACcnZVNlpWTzcxk8uMbFe3vGdRpj2WzFASfBkDtk
         7WCRDqFLMnlPHjks6UvE4F81uqvshoDMNRQXOQJpSF2dXMgNY5fearqALz7TAClQYkRx
         G1JqZ71+EVp3NWdW24RYAI8gxAu/kMXstVJdtyJdMLtf4j7vpPL7eCQ78frnkcqv1+uO
         skkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKBd2Ccr6W/BocgjOJfv+qGhcxRsjJpZTL5Jd6ZEALOMfszuzbWUc6aJJ2BDdpO30XeiPRgD4sOUSp+wU8Tzd0zRqz
X-Gm-Message-State: AOJu0YynR5XjuCfOagiS9dnwb6K8V+7C9efZj7+v+Uq/DjQFmTvG1UnH
	ObxuUj9XcHXr+p4FciuBxfHS1mnemd3H7s0ZL7PzKcs8+iuN0Bs3pOBSlRBA474+iGqt73U9Wze
	yGw==
X-Google-Smtp-Source: AGHT+IEotoxzTcL61fPNPOF1oe83dNOozsClwiQuDb983+6Yt1pcsrrUNKpJf1CMRJIa/y7GeGGj8edECOo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1109:b0:dcd:875:4c40 with SMTP id
 3f1490d57ef6-debb9e3dc10mr825460276.10.1715176891034; Wed, 08 May 2024
 07:01:31 -0700 (PDT)
Date: Wed, 8 May 2024 07:01:29 -0700
In-Reply-To: <ZjsZVUdmDXZOn10l@LeoBras>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <3b2c222b-9ef7-43e2-8ab3-653a5ee824d4@paulmck-laptop>
 <ZjprKm5jG3JYsgGB@google.com> <663a659d-3a6f-4bec-a84b-4dd5fd16c3c1@paulmck-laptop>
 <ZjqWXPFuoYWWcxP3@google.com> <0e239143-65ed-445a-9782-e905527ea572@paulmck-laptop>
 <Zjq9okodmvkywz82@google.com> <ZjrClk4Lqw_cLO5A@google.com>
 <Zjroo8OsYcVJLsYO@LeoBras> <b44962dd-7b8a-4201-90b7-4c39ba20e28d@paulmck-laptop>
 <ZjsZVUdmDXZOn10l@LeoBras>
Message-ID: <ZjuFuZHKUy7n6-sG@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 08, 2024, Leonardo Bras wrote:
> Something just hit me, and maybe I need to propose something more generic.

Yes.  This is what I was trying to get across with my complaints about keying off
of the last VM-Exit time.  It's effectively a broad stroke "this task will likely
be quiescent soon" and so the core concept/functionality belongs in common code,
not KVM.
