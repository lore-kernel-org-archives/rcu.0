Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F13F412C
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784018; cv=pass; b=cxZBGU3d+tgPZsMDge1qkWYjXk1pcN9zCZwsjFX+yRUQEIlvnk49FtzvAkmPYy4JavY0MoMoUBh80uEFTbfenMAIOi1oPqHLZ9endCi4BLux0p7WcbfmOj/k4+G3CUO7zwA+tLLr3eFU6k6aZ5a/nluGg8IioPtkIrYeJnOHsiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784018; c=relaxed/simple;
	bh=81/aNoi63Unr0KciRRcWD9mwbhnyiv2BKpKkKoXYCi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH7W5E18mB442Zqw2qNR/WsMW2dkE0lJTWhEYziU1heRZfKeg+wnzO1nTJu+BLV2k1P0mcCYJLpXAkd8ntqakhs7cy6QDhTvEDGHFDZhknkxUInAE6iPgAEff9RDLQfzPgC9tpwC/2KEuNRJ9+UTD/xwbQxM0QG9sKtsk13tx84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXj4EsVW; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXj4EsVW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4645995069bso319334f8f.1
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 05:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781784015; cv=none;
        d=google.com; s=arc-20240605;
        b=gfcTRD2RIhkH76T8/AREMKT83JBPrxSakYug6pm3wTUj1ev4I58nxw8iBci/uslr4Y
         5MbRIVgsSjrAdUthm4TjaQNnZYNz9MQk+ETmP7I14c2Mt34y3DRAaRKB9Snro1uSo1/w
         1ReTdLuyqn3eaDnqfG4ZJZlIrr/yv3+7NPhALKjZwChQXXA7/NZl+VSbsDT62Lzcdl12
         HDKKW3FGAx/A7DW0j4wkzXbUgc2Onl9JUTcm28WoSuhzix06gQz/r4tO27Uk6NWYgQpk
         PRWq/MiuYksSLIatD0l8k/CGHRdgh6rWZ+FpzDj0IY2PjUz2KnGQXczimqI33CflqX3P
         kQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=81/aNoi63Unr0KciRRcWD9mwbhnyiv2BKpKkKoXYCi4=;
        fh=aEIc0oLDDv80Gjh9fg341+9ohCzu1qe45HQGDTGuVAE=;
        b=jC90ASZe3W0YjgdclHxWlocuVaukKcSH8aDA8rA9xQvkC1+KcvgpPDGeBb33CRlZUF
         1WfZ09JRx5htsy+gRQ2J8D/+D+JhYEzkXDmKWeBEJSwtBJbmVMP9M5sTTl2d6TjmmGbP
         zvCdNUjfjYokrnaHnu3OOrHG7hCoPyChqBxQch/KRh5Yho+uDASvLSCdGzJdqQ3UqfbH
         7MX1gZ7WB4PiLqWJwDWL9OamYvgf0jJ6AsaUsAecAeQuTThzTpU01ZePYSDQDgPYRe09
         x0y6ItljvD/d9zYl1FNWCgh+yD9qYd8Sr2AMtgJfy7rrUhMoDix+/L5m4mGwuIcWjmxg
         KaSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781784015; x=1782388815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81/aNoi63Unr0KciRRcWD9mwbhnyiv2BKpKkKoXYCi4=;
        b=CXj4EsVW5Lj0uU0EJbHTBAuU3OVNbBjl3aelrrW/DeZdhik7/Nvh8ww2V1eiMH3RVL
         cqXQRWowT6CZ15VREU8g23utiQq5CcP15kSXtg5+uEaX8FcxvNy/O+xLVX0vVNkP0fm9
         YiRaszhUDqc5nHTGdZnY7sMsEP0Yok5kZ9qXHF12WSAKhIgNM3s9z9bYlEk+esmEDpiW
         pj6JyX4hjNQXdmsYcRzizo3cFYHXtUls9KrGzNNg4y2H1tiKbLV8HOIVnP/FRsMPv0sv
         66a6az1bIOK+2kQwWkQEXDABjBnk889jcfmZgzdFqeP1Xu/+X1fLJ7jSfBfwZWLvTRnk
         /zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781784015; x=1782388815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81/aNoi63Unr0KciRRcWD9mwbhnyiv2BKpKkKoXYCi4=;
        b=XjSP7yXS7Y3qfh1ncrXms3r7Qg+wIas7uPyMRmK4jSIO2sUE/DQfHEbBeNecUkcf7a
         bv6k5HwrctHt15da6mhM0+dXZ71zs1d8+8onUkjm6RzNFzvC1CMn0xh6ttqDmuFHT+8u
         McgexwVmf6d3tSG09D5UCArgg5VDa9Rjhc99nGyaOXDsNiAk5+cJ52DlMd+q6QdWyQEE
         tad5uKF0yIEjVa61qp/BGtcpMpRiViv2xWpxStDExh2cqj8ZT+ixfeX6ObtnVBcZJgJz
         iqLk1Bega7FCx3LX3Ej7cypYdYyzRLEv2sllIRff3gptVyflmKKPFFfwjnYmAhpZmblR
         o4gQ==
X-Forwarded-Encrypted: i=1; AFNElJ9akXyVGvbxzfsMtb0v18cbCdE/Mqih4H+xk3TVBIE0YN+dKMmyEGKIxKOjA4zaZaLopr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDxbcxh+3bFoTrJN0hK7JVdO9lk0aE+GUzlMl8QR6Dbtl4sAc
	7RNT53LTbOaQBAloPSPYAgbGwvrelWCUoRb8/CsPR4dTmL/YWhF0QeeaB3iEufuK6A3I4LHRxpk
	H7soVkuRXbsdHeD7dfJFJnC6/T2RZjDRhjdzsP+yy
X-Gm-Gg: AfdE7ckJ2tNdyTe9va4FELitaSLzpyr/i/21DVfhcygED1GxWfXH8crMTl0+QTX0uLq
	j5XS1JUSh9v2WXrKAnV9z2oVPykUKguCdvFtqdCgxhZ8sqDeplFSIWZj3PfDlIvAFwrpwO++/rm
	6GhV83glBpALtPuceY5YZBp4LbuQ5ewfgga/Ouezka8+tXsO89s81pNkXGBwLA+0LlGni6LpBA2
	FkE35O9g9STDiLMdLMOGUmX6/HdDuOao+XWHCHaQXkZVq9tFB2gSjKT2bSafQ6Mm3mr7XBAZyn6
	Xy8zWidwv81k3/U+DNfY3Rk0IVg3sL0CxWnxKkXA0pIcG8odNLCZKvtezyY=
X-Received: by 2002:a5d:5e8b:0:b0:460:efd:c682 with SMTP id
 ffacd0b85a97d-463ace19026mr5485479f8f.24.1781784014317; Thu, 18 Jun 2026
 05:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-4-phasta@kernel.org>
In-Reply-To: <20260618095952.3687099-4-phasta@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Jun 2026 14:00:01 +0200
X-Gm-Features: AVVi8Cd9kHkmSQPgeBR6CxVVcsbl0p2YKmtPm8wUPVpL_M-iVZofLftfM_oENK8
Message-ID: <CAH5fLgj+-Y4XM3ev8cCfes0Qow5Ew=cmyqbPqog3t7OgDNPH1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lyude Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Christian Schrefl <chrisi.schrefl@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 12:01=E2=80=AFPM Philipp Stanner <phasta@kernel.org=
> wrote:
>
> We now have a safe wrapper for the foreign function synchronize_rcu().
>
> Use it in poll.rs.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
