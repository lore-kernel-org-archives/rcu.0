Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793567238;
	b=Wf126zF+Gnvdpq5ZP88TiMI94+1blzrB+98bYDsGqP00RmCQhnIH0IMhw0SBEqHtEXTo
	 QOsYkq+s1/fq4LI3LAGZKz9pW9cHSbJ43gxLqDGGa7IrLiSfd9qRn83dLwPIHbNtfo7Fd
	 /coP9ro6CzassE4Q3xI4aYWsuxBmzdKnuoCMYWMUk3krRJuSrFsiAERJ+CLhcY6Klvn9r
	 nwSys5I+hfsRHVzX0BXsib7D0QmUY3uZgQImxrdbJ0WSxEP6LRbW+RMqAoe7jbxFqgwOg
	 8krUcbq8WRDgJl0N0HPgt/A7B7qCHPH/SJSAxQYfnYvpFeJcui38+eb3gJ02X83O4KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793567238;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uBtK4Uii2Z/syuVxoiWD5aDotjazeSSHixcnfiiNqGs=;
	b=Wz30XSoKqtCDrM7zRrms7VPeOdHncc0DhENE6Pv/OjPLahXeq1Ant1kCXFwOjKy6CfFC
	 EQC5X1ZLfn4zKh9hvsSDN31jOoSI19Pm/hoUdrkdi54EyuUiPaouoFuDp5G6ueWlk1ytT
	 l2X6v/DU9XOe+UGWLlwipgYeSkL3WOcjqowvlN07XoS6ms+YloJ+sCKNe0fj0bMw+t+D3
	 Bv4w6gzMZB0VoLkMClA0Llw33FPJs5uVs2f4vaKlCFEVPQWEr0WiRLjFONFibmHHeCtPB
	 MLUBtLFGBWimaX8Qv2s7UTX9g6OL317CX0oKu1znLY5hw/WRbUK8PAVoWI3fF0dDiQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkSf1Zmn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8306606A324
	for <rcu@vger.kernel.org>; Sun,  1 Nov 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkSf1Zmn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592C61F00A15
	for <rcu@vger.kernel.org>; Sun,  1 Nov 2026 21:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793567237;
	bh=uBtK4Uii2Z/syuVxoiWD5aDotjazeSSHixcnfiiNqGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UkSf1Zmnp1uyNO50H1VYvb3iB4ZDRd8wGoFOrJrwYZqw00pRSHWM8+PJc4/YovtRU
	 PsmfuCx1bT0MPZ2sQyIh66wgZYOFZK67li56HxijDNOL5r9d/V7Dl0wh2j/OlPZ0WH
	 iOFRwTb3/en71nrtIFF3rJ9fVCCGzCF85hf7NRP+Z7ywgWLGKPdt14/UUJEtGOBeha
	 eSSy1YnuX/HHWDe+G6VeKhj1JTee8ap+6y4CMEwj44pyyBvaqdWvzZZMFdz0x7Rh0c
	 b1k4tz532PgYeCUtCjILwWjHerrGaBcm/0AdUxZUuLeHmAS7c/8cDz4BpdGbP7y4tK
	 EquQO09hI/t9A==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f30660e69so170440685a.0
        for <rcu@vger.kernel.org>; Sun, 01 Nov 2026 13:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByogo8+2CEnD9rMarjpU0kPujb9v1pQN+IZdeHlyNcfgWX7BnevwKowZCDObpRKEnasA4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkdMBpCNUuwW14YnXHi4cHahOLkSjHVD8gQmudxaMqFHhAVv9U
	BguuG1uzE9LmXImwZnpQdLho8I4aKG30Pb7sOP4mLj1rRJwhuyeobOAmQv40OCISiDxxDfNF9FS
	LGyO/b5tnNSBbjNk95n6bAkdU3Jdb/V0=
X-Received: by 2002:a05:620a:688e:b0:93e:c12c:4412 with SMTP id
 af79cd13be357-944217f079dmr1343599285a.78.1793567236722; Sun, 01 Nov 2026
 13:07:16 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
 <20261012205447.2717801-2-max.kellermann@ionos.com> <7037ee68-5dcb-46ed-a73f-ed6ea58915f4@paulmck-laptop>
In-Reply-To: <7037ee68-5dcb-46ed-a73f-ed6ea58915f4@paulmck-laptop>
From: Barry Song <baohua@kernel.org>
Date: Mon, 2 Nov 2026 05:07:05 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4znEifrb_5vVbkVENmTdVLeGgOyfaYqptNXk15kQ6xr-Q@mail.gmail.com>
X-Gm-Features: AclHuK_GLhoQTQql-sHZc5DrMSM4g6S1w1l6RaNWA69ZyNHwnlgREaXUECvpfuY
Message-ID: <CAGsJ_4znEifrb_5vVbkVENmTdVLeGgOyfaYqptNXk15kQ6xr-Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux/rculist_nulls: add hlist_nulls_add_behind_rcu()
To: paulmck@kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org, kasong@tencent.com, 
	qi.zheng@linux.dev, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
	baolin.wang@linux.alibaba.com, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:58=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Oct 12, 2026 at 10:54:43PM +0200, Max Kellermann wrote:
> > Move some code from hlist_nulls_add_tail_rcu() to the new function
> > hlist_nulls_add_behind_rcu() for callers that already know the last
> > node of an `hlist_nulls` list, to allow constant-time appends.
> >
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
>
> I am assuming that this commit should take the same path as the rest
> of them.  So:

I guess it would still go through Andrew's mm tree.

>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>

+1
Reviewed-by: Barry Song <baohua@kernel.org>
