Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F91C1AC2
	for <rcu@vger.kernel.org>; Thu,  3 Oct 2024 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993402; cv=none; b=gCjcBJpxZpUFI7Cd/GgWTfN3Usa/v47d5sj8HYLrJvoEyy5Uq5iIgXkNxk09P2YJNDz75pL9tipNHnxlpa/JCbTrf3t8WkJ9LThYpvjNOP0slCV8iZVSRPTFPu9f/8OOAzxMdLyskY7SfxTPG1FPYga3j3ehetD9w8auRibkXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993402; c=relaxed/simple;
	bh=RIEY/VvBXBpbOFws0YW9ZSyNHIhNNXGVpnHlXG+8ISU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFcv3HcvKcvw3+c6VUasr3tHpMqGFyjrRvX2uytb4ogTEe+IkuZOC5Mw/sRbOLR/gRZKkML56Pix846pgp1Sa3XHkkBOgR3npgxDpTPsvBmblK+3aDfEKGDR6pn1kUmU5K+kNBOPNjc/KlIMev6IKqtWQRm4dDSZRJZdeqWIjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=WchwMOl3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WchwMOl3"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e04196b7603so1264830276.0
        for <rcu@vger.kernel.org>; Thu, 03 Oct 2024 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1727993400; x=1728598200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIEY/VvBXBpbOFws0YW9ZSyNHIhNNXGVpnHlXG+8ISU=;
        b=WchwMOl30te9L8PjAbs2ejtyRADtSvVFtZkunYWEcQ9dYk1iMbJ6xloJg4vEOu+4VM
         YkFYBFYs15Fqo73JHPl00vOnH1rqJIMZQOtT3WA6qRWYWk7YmVXqn4DeWvM1xbFb69/I
         +aAt/ytU+RKvMeEFhe2wXjwb6soevV+5+A2Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993400; x=1728598200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIEY/VvBXBpbOFws0YW9ZSyNHIhNNXGVpnHlXG+8ISU=;
        b=VnZ7rZCck7ucvASuwL8XGrT5pLzbSx/Yk73Z9G3bWQpjW3t0g2/r7hh2o5VeMS0ZQV
         5Z1Rs0w/NG10dnvglbNulM0/d5Pkr3mu0ZbPVZ8++FT6g0rsJUXEEf2RGmZ+RrNjDsOz
         MqvfojA88WD4f/vTsWHh9kriSB55ig1GwUGIemXn8lxZe0ho69NVlJpzSdMgbvOzFA6Z
         6nlB4FP9mvmJrng4szPTDbBwUY+uE2lypqgUvgulmiCpTN8c0lw95fgu+VFhznb98Fzp
         vFAST+BUeoOfYYat2XsACicS0vrFKZTJG9F3gn6uSJssRNQcNpzG6k76RZtWB4DDB9UO
         4yJg==
X-Forwarded-Encrypted: i=1; AJvYcCXEZjMHjCaxYjtuYfky1nWOpTN658lt5cM8GgtGBj0OqQG8gG+Y7+oBdqQRolI7KOZVMV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDl0yaSd5AlvUd5NIrN5DASI4nxc+V8d1svxaEfuIfQit9t76v
	+0/Wx4ouHtovCNkCqrP1U6wXYfug0fWe/MHoGmXP12yZCMp6wlxykuwhBpQ9acFeE8yEFkWpBxO
	zroL8/kbvcx62/cBygQXoSQJD+ptYl6UrfTJsvg==
X-Google-Smtp-Source: AGHT+IGHUNzUYhVLVAPDGU9H/0WV5ShOsg0ptxWufYbLbDAiDNM07Pwk/MoJ8LvG3kzNc/NTlu+JDUt/1ryUfofqvJ8=
X-Received: by 2002:a05:6902:2b8e:b0:e26:11ae:6de9 with SMTP id
 3f1490d57ef6-e28939561eemr459827276.52.1727993399239; Thu, 03 Oct 2024
 15:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
 <20241002010205.1341915-2-mathieu.desnoyers@efficios.com> <20241003000843.GA192403@google.com>
 <7cc83ffc-c9cc-4e87-a3ee-bb62588a594c@efficios.com>
In-Reply-To: <7cc83ffc-c9cc-4e87-a3ee-bb62588a594c@efficios.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 3 Oct 2024 18:09:48 -0400
Message-ID: <CAEXW_YTO3AhHAqrA4E_goVbsNB26AdfdShynr-nNMR97AYy6ag@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] compiler.h: Introduce ptr_eq() to preserve
 address dependency
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, 
	Mateusz Guzik <mjguzik@gmail.com>, Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, 
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev, 
	Gary Guo <gary@garyguo.net>, Nikita Popov <github@npopov.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:21=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> >
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Please double-check with -O2, and let me know if you still agree with
> the patch :)
>

You are quite right, with -O2 I can indeed see that the optimize hide
var fixes it.

FWIW:
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks!

 - Joel
