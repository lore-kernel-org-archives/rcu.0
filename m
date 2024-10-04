Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9B748D
	for <rcu@vger.kernel.org>; Fri,  4 Oct 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076530; cv=none; b=KO2Dvw66x143SH5zuoofxaPM/Ycddmn0ered+FI54WI5msaoLu2qRiW/n7fklUjVecTZ+QWXV9YERgCxXHjbTj5QL1tsNJCL7fa7BXjauoDNgRjnBfd4WtMCWUeTFZtp2CtGuhTiBzUDzx9XQNsN4r4A04wB6wxZmUfE6+UPzdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076530; c=relaxed/simple;
	bh=Mbx5r2TKIMn8mhKB+ZeVXt4Prsj555X1UtYtHQwuAzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovfJa3UMYBmLvtfP6XG6NeEAhM4g/n/g/YaKBbOS8e97zwL21GgJ22Ap2vHnB8EpTz+qny0pl5hv5wkUyr3FM9XdH4ale+NAQYXXtyMYoekDjjcX8MIkyL654JND3MnCVBTjCgo1dY7s9DSynULr5yNg1bH7fZA8Vcpm+f7XNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=UmLA+ajU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UmLA+ajU"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2732745276.0
        for <rcu@vger.kernel.org>; Fri, 04 Oct 2024 14:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1728076527; x=1728681327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbx5r2TKIMn8mhKB+ZeVXt4Prsj555X1UtYtHQwuAzs=;
        b=UmLA+ajU4Y9DJQ8OiTIFRrEuHTPlMb5w28rxfGkCt4L6izh8MpuLL8a1P+ijgyx8PK
         kKj19AUPIrq9os6L0mtqmnMJKz5oLeZeHb1KL7x3BVSXmlxwrR+KHzhkwPCxv1TIkyOK
         iUArA1BneHH2wRDnN0HttYcxneyPdWn2ICZ+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728076527; x=1728681327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mbx5r2TKIMn8mhKB+ZeVXt4Prsj555X1UtYtHQwuAzs=;
        b=It63a9vFIVBVi1o8Y0wLYj4L9l46B7+aRqwMHot4Iqc7/h8iacwD8rdhuPC3bu0hWc
         9UG28NAzGHpRVFR3u8GcAKfO1GwIaKOI2Tw43CcBDYnTYLAhJwJWRgI6RJXdFR1uK0Fa
         4k7nxB7wuDeCSCBB3iilzwnKkgVSKZ1lw4SD+DQsFbHvafiu8RO6A4DL9eT76swyc5Zm
         FbLgN9yHqohTvwpAjsdLTw8LoDk76asxCab56iab7fMaZAPE+VrVGeoYWbKhAn4ErZVI
         0Gz29aQHEToA1hBE4AHgI45Ush0+bAJMVlRY4R7zBYHVDtGgIlYd9E9/J7xHCThuXiA/
         dx5A==
X-Forwarded-Encrypted: i=1; AJvYcCVm3PFOyMppZPNWjjorPyJ7/1SCWTXpvfsKuaDbLIlsNv75TrNRsiGKfLPufd05yPYYOhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvmEZ5+S6AIQ6x65QiQsSIhzPduarxHEgQCYwl8pKEjv9lYYQ
	gYdBsuBaWkvYCWLPktiT5oM9yQZPzbohKYowIasLKvgJBSwsnHtxCMWmUqdf/hwxtw2exduoLXE
	jdDRX9K3Jv9lwoUOF4Biinbco7lrHboDL3rtWlA==
X-Google-Smtp-Source: AGHT+IEPsLMnMKFXypAW2Ai1WtaX3NPqnW63QWoysrWAhTsUF8m+CHhPihaOdD4n+hkJeUszvqpfldEllQccT98CgOg=
X-Received: by 2002:a05:6902:27c7:b0:e22:5b5b:58ad with SMTP id
 3f1490d57ef6-e2893944237mr3839551276.54.1728076526729; Fri, 04 Oct 2024
 14:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com> <20241004182734.1761555-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241004182734.1761555-3-mathieu.desnoyers@efficios.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 4 Oct 2024 17:15:15 -0400
Message-ID: <CAEXW_YQL3wY+BSMw3SOxDWbczrVfe9ALz8wqRjb9iPOBJq0xHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] Documentation: RCU: Refer to ptr_eq()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	John Stultz <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev, Gary Guo <gary@garyguo.net>, Nikita Popov <github@npopov.com>, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:29=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Refer to ptr_eq() in the rcu_dereference() documentation.
>
> ptr_eq() is a mechanism that preserves address dependencies when
> comparing pointers, and should be favored when comparing a pointer
> obtained from rcu_dereference() against another pointer.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: John Stultz <jstultz@google.com>
> Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
