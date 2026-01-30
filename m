Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DB239E88
	for <rcu@vger.kernel.org>; Fri, 30 Jan 2026 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748134; cv=pass; b=pzg6A9qCLJw3lhzDkuYwu4bixd3IVzuQiU03IH0E2z95GffRzpCcYB7YmHpKVpMS77Ljk3DLWBWl3TMGy6pqDusrxywYScZmoTLyqWqRt65l0advs3Pl92OMKTFfxNO9FdhMtUurd+Fi6L0X3KxpLez9cazdaBMcCu+UMkobBv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748134; c=relaxed/simple;
	bh=9AtXd8g8cv324hiwUaOLJkTtg+EH4HxvCYA3UxkJaWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coq3vAMcC4KWwktPdfodrx/rKbtAwfbTCayYgWBI2aCoPXOFUcnwLatb6CmGRcOwvEcvPsofnaSy1tzT5XOBmauUjM6S7uAShJW3EjDTSapirWweNPHW1vYqain6nyUfo9sGnpA5xRPrKzRal5VSWkXy/CrX7JQmwaw/z2FaXJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkIDdzpm; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkIDdzpm"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1233bc11279so5852c88.1
        for <rcu@vger.kernel.org>; Thu, 29 Jan 2026 20:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769748132; cv=none;
        d=google.com; s=arc-20240605;
        b=Tm0veN9o1QimRkKMrETy1uBbTOOLMk6QZFhdpc0zGwtzfh0/HwxYB/R+Qr/iFsedKW
         eThjB3NHq9dfLeVadia30FQZh43v0stWVv/2u884NGHZlSma/o1NEEpJInnuuWUBI654
         xKRmt1IMciQIZzqdW37ClYNJoOxaPH2oDrzj34xMXo4ADudO4eAenWnRSe5vFWvNawtg
         Ts7CFpGDEf1uhwKpE+HaDxEkJr3tzoSCRy12pElIXTvBnedBP4MBKWmu/bUI8gMhmVmN
         ZA74Ba3O5k090SGvsNJ78OiMXoIqF+ofbi5gQv7Zp6eJnEIf+ZJc5IHb9TfhwVH4WtrK
         7vbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRhqTEHqwyvVmwdWFyLPo5xELcEwDSdFsxzHqxGTMCs=;
        fh=CAnkh3SY1ctb7zDSdpeev9adMILuoPajnIJY/LeRw60=;
        b=FqwQZS/NDRNk9Fis+ykpjzPeoBIH1WAAdBKtKCxl000+wSU2DaqT1pHkChnt+EvkVk
         w4EDXOw1/PWNpWSlKPC2g5w9VTq/0Xnn/P+lMeSaF3rZbOD4SBjKuILsbx7OKbUP6e6o
         QUxWUrUmS3nlJ01M0njRbItBJ3YjCBIG/4d0Ejt3qWTJ4ZfAVOqvbeAH07RzU+V/bExU
         MjpnJw02Ir0wYUQmePXExqKpcarzwDB8k8QQMI63dBiqRjhvndJR43OMcLQcki/2rYSa
         eC2rYrMYvsagFd2xx108+R9/BWcRz2o+cJuCJvVPdoqI4AI9CjCIzAfoNglKyiejkk4s
         1nTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769748132; x=1770352932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRhqTEHqwyvVmwdWFyLPo5xELcEwDSdFsxzHqxGTMCs=;
        b=gkIDdzpmtE9+kJpMumRJ7OS8TJ5D5jc5lS346q/pDHhicEpDU+6Dxoe7NJiKfqYPzf
         5UvDCi5jSVB3oQcfAc8PQOEDHXcZJUT/WVIaPVgKRF/6qQ3+4lAkfcUkMGVc6aLoVRUm
         OmPRXIVZkZu4LMwLZ6KUihEbJNf79CmJ1a6iBl+Leo6UDg09GRV9GsZT9iXYMrtrc5Wk
         O+qj/D9vyM8LJpCSLq0FhLDAZNUby4XYwgn7nfAPserKZFZuCe4vG1KhaiHriwZtYLaw
         NYv6rqDBCJDlRDCsbBpXkQTIgN9AZKrl21NLgoK+6PkNGoToC+waiyQr8wqjFjdsIqTn
         W/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769748132; x=1770352932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRhqTEHqwyvVmwdWFyLPo5xELcEwDSdFsxzHqxGTMCs=;
        b=D137Wx0vFnjUUVh3SQ5xmj2GUYrwS0MAmZX9TT+YJgrjqISyuZyxR/Dhfbpy6RSVv3
         +n8BarYnkqeo6le0TmeCJnH6IBxGb16DLtuLDPRR+TD6wUcEBOKjLTvV3AtO33uOVxAz
         C05HKMfDPrMLNAvcLZMmP4ELTYcbrO1L34h7qtcJyHVuCSJMBOICnpvrv73CWMpYtBNZ
         YcN2xuYCB8kFg8Czo3LGjHOCmiPLRqSCdqGLdtJH0VgDtHdQ35h6cwkU76g9UNdqhZt1
         m/xvEYZOH0pJxJpQkFUvxVLR/yNzCx6T6O8/DcJYj24L0ph4AbunRdConZGujoIwkKkx
         JQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyq4mMXBJYjVBNQohzndv5ybcqZHgCaP4DssLwR+bsozdpeBeeaa6FSdGZiS6R3l7s3xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRSG1IMGCzNGg1+yBUrfEtb2dlbaKfFqB9qH+uL4BjPT7M1VD
	XNNHO28KnK8XgSoStknLs4+smOCKyJSG/foErERBEDBRaJIMk6j/YgwN9rJwstdashhmyELzZ+p
	wI6pmZDZWHug43GvfsIAjxakvHZU2n+4=
X-Gm-Gg: AZuq6aL0uSYhYOE63vH83rguhj4AQnpA6M5wlhMCAmA5nbhsUCsIcKzMJVHwVU86za/
	H/+fQxWIv+g46/GaFk0Jh5y7zkMyCzmxMYIx29KZydzGej6GnfxIcV37OdxoL2ZK+giPxPhOARZ
	Juuvvz5XVmgPWtxyahIqW+kt3rcYS0EuF1QOsXn7ByPUUmuWkyp0rAhgQIDo1X/4X0Rd1mNtW/u
	Grtcg4Bc6r0JKaBCq4/XwhgrCif/dvykwqr6U6Yb/leNpjTPozUovsY5XRqQB2N0KLJQFiQPbSI
	tk1D2t4b35RAAEku3Uc0Xdhi01q/B3uWNP9RWAP5gP3yR3d6wChuE/4L68qlFTsgWOaoEm7vifJ
	sDYh1gJ+svNnG
X-Received: by 2002:a05:7022:906:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-125c1018f83mr463923c88.7.1769748131683; Thu, 29 Jan 2026
 20:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129004520.62697-1-boqun@kernel.org>
In-Reply-To: <20260129004520.62697-1-boqun@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 30 Jan 2026 05:41:57 +0100
X-Gm-Features: AZwV_QgKWHn9P9hd8qHR3QNl6yV8Hn92j4G2YSbbe9naoXr792u2X3ZGzLx2RN0
Message-ID: <CANiq72=MkDXW-qa9sqGnAbFyz9V74QCkBch1fodAY43_Zkvr+w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update my email address to @kernel.org
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	rcu@vger.kernel.org, lkmm@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
	Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 1:45=E2=80=AFAM Boqun Feng <boqun@kernel.org> wrote=
:
>
> I had issues using my gmail account multiple times this week, hence
> switch to @kernel.org.

Applied to `rust-next` -- thanks everyone!

    [ Sorted alphabetically in mailmap. Removed Cc tag list. - Miguel ]

Cheers,
Miguel
