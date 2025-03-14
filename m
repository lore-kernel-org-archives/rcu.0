Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B3202C21;
	Fri, 14 Mar 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963418; cv=none; b=Y5QDwkXYQTsUZzjrD4sPiz2gwc0lFBWhPzPUD7D8ZGxnRxC/lcsfdKVWgByrMMD/aN2518tkzD2LOmu5BoYHFAN1vB4V7uTLzbf9aQS1jymyq2rj9uiofaAlCMO8dInB+wBPOquZ1T4uktFJzb72Cu3L7J4oOydUcNFNhs8WKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963418; c=relaxed/simple;
	bh=XlYepE0qm5GS8Ms85NOW2h1KCpwn8+/laEx53InJ+i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miq3x5kNT0TkfVwLnnSGiwylajVTCwH84osJXLMAik+30Vvr39PLGRErrwN4emsuj7eVqGZE4/X25/Nd3D5hpEOtjzsYCJ2/WCSszg8CPmkiWyZxU0K8QjCFhNLCube5f5pRSr7ergnUQmPUdDvUHVQiTUK/n+0nyS1a9+RnXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg0iiy0V; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg0iiy0V"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301317939a0so508403a91.2;
        Fri, 14 Mar 2025 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741963417; x=1742568217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlYepE0qm5GS8Ms85NOW2h1KCpwn8+/laEx53InJ+i0=;
        b=Rg0iiy0VnUsbiislzoQ/wIpGr3luq0m86cz/pjTxR7lR87Bgg5LxstWEEYCj8lov96
         mRcQzPltrun3rN+kQvbEHs5+JICI1x9wnVYyrCrDId//8izRzu0t+H4kvZ/S+ABDAgow
         qNjBvPbMvTGEfukudNzKOZaK/8an0c/Gut7vDMyqXtfX1l5jlMfyPK60+nj30BJp09t/
         n5nzbq2qNb32qPA9EXAhkT7Di2r8DzTNsgtX+AU+AYswpSJLvm0I6bXhfOTdCmDg2ujZ
         L8Z8foOageysz2dJG8rmLhzlFBTANkvj+0qxM5YrMi9+2NyaR+d7/T/5+iXYeuWF6Hv3
         Todg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963417; x=1742568217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlYepE0qm5GS8Ms85NOW2h1KCpwn8+/laEx53InJ+i0=;
        b=oJxCOl3W0JCAGkn6B8hlmIP8mYJ81ukT78dakixTWNd+WfhqMlu52PAu7TLzmly+oP
         7Iz6BWsuXoSgSr1J+IvPKP5/9PwltEgZiozU1X1Sg5zbBIks4QqxqNARkN8ptbE1bEv+
         ZHkF5YuDaEhIm6NgTo0FJBWBQFR1K8xCYlzyTEPzuJyQG57IkSYJLTR58HcpmF4j4XIz
         EXGdrRYWjt/9XjL+AHE8JwWHtbxhEgm83Si8VmLIIUfCNaASmy/De6BjLoriPtLgwT83
         6Ps9YS0ssJG51L346WcF0V5n18F3vDzuLptDP2vxcNvPXp0uUkOu1OrOFijj6ttergVq
         PF2A==
X-Forwarded-Encrypted: i=1; AJvYcCV9Xug4eF1Z8ZSaYQyQwOG0Iq7XSR18SpCavwiWT3/ShAodUKJdh7h/4Ai19O5T2czKmYjAKRdfrJSXysY=@vger.kernel.org, AJvYcCW99RRGI1Lvb2tu5LI9CvgyaeYLayimx4s73kbejiyIyr/4j5hn9E75Keud7oUO37grB5Q9@vger.kernel.org, AJvYcCWKf+V2Iq2hyA1mp+l0W1lBPpKulLmnL12uBM+s39tHV9W3cDoGvJ8l3L0xVmnGaZ1AzUxpebkESbsG7ZseJO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4r7pO+m5UUR6QI+PvZhStUU+jdPTMU8d29KXFsHO7CmzduTJ
	d6Sa9PIQGIjFnOP1QupfC8AUqcktPpfd9DTYmULfWkSZTOWF8Z9p0aA/yW7Hf6jMgbBsl7gt0RR
	fXa0uukzrJsttsND8A+hssNVQbA8=
X-Gm-Gg: ASbGncuk6B1UWz/mvE9sqMzWDyN157m2h/gUJ5M5HQFdv75gAY+DX6wGRAtXjYQ6ehK
	ou3vBDiPYzPeaiDYJJnWGOQTJ2ObUsRnoyX/LuQCWupr7sHbJlbJ6dnB/ngHBU8CMsymyXxfwoP
	7Bx2/ptF9Cwpb/vG6lIkoapDjCPg==
X-Google-Smtp-Source: AGHT+IGrQ+XJ1EOoVoOVpa/rZyFLtn7pDDFG2lG8nu+cAc3IqwYiYm4lfiaEKGMt0ILOHT7mZysUFHafTEnb4rjqd90=
X-Received: by 2002:a17:90b:4f82:b0:2ff:7c5a:216d with SMTP id
 98e67ed59e1d1-30151d8178fmr1503361a91.5.1741963416698; Fri, 14 Mar 2025
 07:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312101723.149135-1-richard120310@gmail.com> <20250313043006.GA1396688@joelnvbox>
In-Reply-To: <20250313043006.GA1396688@joelnvbox>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Mar 2025 15:43:23 +0100
X-Gm-Features: AQ5f1JpdKA2_xM48XN7Rbmeslc2fqSu4W8JItvhuGzx6_FCp0JcLccJntLsSGCo
Message-ID: <CANiq72m3pDny0fUkg4XAFsuA72ku0BKcoj5+zKza=o6Ek_QASQ@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: rcu: Mark Guard methods as inline
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, rostedt@goodmis.org, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang1211@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, rcu@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	jserv@ccns.ncku.edu.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 5:30=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>
> If no objections, I can queue it for 6.16 but let me know if Rust maintai=
ners
> prefer to take it.

Thanks! That would be great -- FWIW:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

By the way, should `read_lock()` be marked too? It just calls another
(now `#[inline]` one).

Cheers,
Miguel
