Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1277157487;
	Mon, 22 Jun 2026 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154045; cv=none; b=Sx94LD8hRtkaWKljmsWeLRcVAYIge/45VgG+R15a8AGZPzGe1RaEMfhypYgKu/CEqIVU4fuoey3T8L1qCdFD31Wr/sZNe5rB3m7lAabMz4gwKP+w0cqZPUpy5BIBQfQuC4yw4J+1ijngPupWyW90t9pbcyxiB/TsQfbFFHAtqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154045; c=relaxed/simple;
	bh=hCkg8hYbYXc9JrwEzg7wqLO6PPnmU114Q46FmCKWRSg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Un6G91eyer/doZBMvOMP17Wd+sVJ91LIB8JHSE5JUsH3UtnSdhePQqJKclZydGJPy+yLxStpiB5r6J9jcrIG8hiqcO4Do6NV++GNJiSbsw+7oSUxOL7+baiYGX7tGToq1pvXHuwJmrBOtWcM3jVLGsjk7hGiQROC7d0bkjmfXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYbkdMcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYbkdMcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD461F000E9;
	Mon, 22 Jun 2026 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782154044;
	bh=+McouJ3hkTGmA66sNXUO5zoGlCSzbHbEHeO4weauw1g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=FYbkdMcPkWjZkG3jpfToALGwm8HxiRCi+Iy49Z10f3+WnGRjLUT+jwxC/K1ftAm8n
	 Sg15F/4vwMXMiqYVXJezsCOAN/KT3YHCX5/+i8D3d/xaze9kh8MbWHaZGv+B7Y2RWy
	 aqUChOo4ipSDyC5u/cu6UkrGFMBCLYRdis42tDkDpHvkAMka51UTaoOqjMODvxhekq
	 G/65YKCclpEM1rDb3w7g8bx0Q3rNLDqKLEFP6T2dCpgkUCb3xOQnDqrLJQPZ2H3BS6
	 bAJdwwhVviYvy+bmGOWOEnG8A2LTfBTLlvow+HdgVFFfxX1FfpoqcFugaHEcdM8BUc
	 BL6Nr/XxWMegA==
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 20:47:17 +0200
Message-Id: <DJFSVQ7MGLD4.3CO0IAJDUJ29@kernel.org>
Subject: Re: [PATCH v2 0/3] Add and use abstraction for synchronize_rcu()
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Lyude
 Paul" <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, "Zqiang" <qiang.zhang@linux.dev>, "Christian
 Schrefl" <chrisi.schrefl@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <rcu@vger.kernel.org>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260622173250.411377-2-phasta@kernel.org>
In-Reply-To: <20260622173250.411377-2-phasta@kernel.org>

On Mon Jun 22, 2026 at 7:32 PM CEST, Philipp Stanner wrote:
>   rust: sync: Add abstraction for synchronize_rcu()
>   rust: revocable: Use safe synchronize_rcu() abstraction
>   rust: sync: Use safe synchronize_rcu() abstraction in poll

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
