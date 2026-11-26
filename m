Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662785;
	b=G/VaJd6uNkOHhjcaLzTF69Q88UFwWeq86lTSpd+UaN0BeGXifrbGjhNjz9Ad/LYoPhTQ
	 rsJgoWnmWXMvsUt9Gr31Idn2Kp0Sqf3ugiy8g95EMKr3PEg1LxYi6UfEoqwbgG+wOipQq
	 GZAgJ1SeV7owoAEtTZ36dsxmJY9YC/3jecTWSPlxJqdK1JirvQOLWfZarevkFMqrgiYV4
	 y8DtFW7PyvGr4Oqq2CAKbEaXjPN3dc4150mJDQzXktYCPkeOFGIwAflep2i/kRNkotwB2
	 e/DIoC0ihbxEyvWg+BO7mgrpu2QjVG19vR1lYg8Nze8iTKhY4zcyfZC0g/cOuI5KD/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0u2teU5+DNhXHRl/MB1LD7h44EF6lJ6g1dkNyrP5OEA=;
	b=bTnXtaGIT7S5hyp0nReursfi5M09ovppBzdkjo2/94HubRSev3HjTgaxbD9HvZNlQN5V
	 IfD6tX68vYXEiIGo+cKPwBqLnypnniGk3Phodfomd8Ul3HsnmQ2KtZ34cgNj1nwIR6Dt1
	 7SQ1J7GwltW8cBaHfT7npugIIAY0t1MUubgrP4zNA38f7h/ckhgebDSygJcZxQSSzWm6u
	 Ll2G4soG+WOXFCWSyluier1LLAGhlJQmP/xX67TU47z+WsoXBoMZutjMnjuhd2Nzs7C3b
	 8SBCh+X+GykYZhxfmkFyz6fzf51MfB8PxHw6G+zCBizDPMwWkZPetvfogjEg9iNAibQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UisuFHf+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9D606A326
	for <rcu@vger.kernel.org>; Thu, 26 Nov 2026 03:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD9D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UisuFHf+
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4d07494b0so74792007b3.0
        for <rcu@vger.kernel.org>; Wed, 25 Nov 2026 19:13:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795662784; cv=none;
        d=google.com; s=arc-20260327;
        b=hu41wlS/5ExRFI9Uc6m3+mWykVLMJcVW8DQQ6FBFcdo8/1rPUXMXFJb4XlXji2P3U/
         wRpDmUBveQE7hoFzi+CJQG2equWcRnM9PcNBzMame38qODOM6PcGdrg9fzQ7guNzbAml
         OOPdyI7lwEKumFvWTgxAj3gwuWDV3dRqWAe2W8svfFZDf8Bd+Zd832wCJfHAnAk07wO/
         FkP4/Wmm3e+AT6PjeGUgE6lgC/ywCPh17DRpBU55ZHQcHhryTts0kZVVEOlReYl8vbMo
         mFMj9/609bc0EDxK/XOBDC5ZV7mjmeiP0KAjn6TbtWORMxNZcPyqpdA0PTq7N/WhJtvL
         AmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0u2teU5+DNhXHRl/MB1LD7h44EF6lJ6g1dkNyrP5OEA=;
        fh=xIE0rX0FYkeU9D57VXODEWIHdVamc7EQK2HbI4Igfwk=;
        b=puv6noY25VINXJsDTe6QxGkv8UhEewUI6byI4hD3a9xm7Qk4eqEm8sTWDoQ2HFLJ0a
         j0sld+555DMB5gUbxskqnRuintg6l8+5WdohpqX/4+Vb+8DPmfEItZrfkcifMkhjUnvp
         xjpKySKFYjRpTPtvYo7mNpoAHdNkK/hpvpUAe2ZnzFGg2Id6YeYtj/CEpmiPc1XvFMCP
         NtU4mhgkxF76xZZBxtRVxS1Uvm/pVhUdmbfMHKbaqP84J0IbKxuDMkxeUFX4MVyUnDH9
         fdQOZ3IgfdbgQk6upV9IZxSPW/gdoUAGFia7sDFCsU8zfkcBaptySWSGHbxPSRbvoqZu
         yd2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662784; x=1796267584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0u2teU5+DNhXHRl/MB1LD7h44EF6lJ6g1dkNyrP5OEA=;
        b=UisuFHf+11MsiQEkohokz+1jDpyAqyX++7iLpg29wa6o3zjneM/lyPoL7/X1iNCEvO
         kZScrauJ/qMJ8kMTxa9PFoPJ1TS8z1vpnkJ2zARofylySHngdnuX3MXKPt14xwi57xsW
         lKGFJhN5zuUVkvmiYHg9G2xqhUaazUBCFZvZ/o2kXcCF4v6M55t0XkuGjKZ7viu7LHFr
         JGllJTyjOmxI9DqOjEdaNNZGAZn5Y+OruXKEea+t4GQMCNUMA1wO+NifHnnJxe+LhmGk
         GUwD6owy1Fy+/g9Giv6BbOgVUoDMYWVEhSGcOxlAq/FBCzAaK1Hs97skGyOP0qFngu51
         GsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662784; x=1796267584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0u2teU5+DNhXHRl/MB1LD7h44EF6lJ6g1dkNyrP5OEA=;
        b=lT/kZ0HtQwYman0nCwLr5z6e+skObMW/ddhFfMaqmYmmWEyQ5qcoNwf0PgsjVsJM8x
         xlic8DBcltiLiFjRMNkhgsYVMlWZD9ULt4ktvl4O9j5mW55Wpn9QmHEK4/OO+0qVOfwG
         ShUzVTw2LZVx/CEJMlig/qE0k4Ryg6IdOi0ODIOmPCCOW1k/Igf7lWQdsDsboLjg53nI
         19JQmXf1PFvz4pO/XfdKvfPKvUooM2HNZzSa8372pwJ9UXNXX8SfAvYirhmqtmZQcr7I
         EAonK0o/7HMA/pl8qeC0Mbf0XdTGKAFKkvT7O0bbDvd8SjxM5tl+6fWbOcxi/Dn6Uoot
         bGYA==
X-Forwarded-Encrypted: i=1; AL+hErGgazc6GuFXOYg2YtI9xQ1cM86n1qnfXPnHWxMzDVy1oXW6A63BQcl8YpbfD8aVGxlEczk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/jrx6QsBkjuJSqlAiJ9rnLut4Qt3upxvCK3/+lirv8Bl7UpwLx
	SN1iZCwWBT3i7gcQp7kwwuqLmLOVGEkReag8vHhTy2Ze6lsHUoUxZ29Ha4Cub4uQTmezeB4D9pA
	YxyMoxDBw+W9uZtr7faK/LvaTt17DvcM=
X-Gm-Gg: AZFdTZeWFbQqwPfqlhTNqNyyQF5GdBtpl0tzr8ruzpeKNduLJUUdwbnROxCU+rZ/E4W
	kjsJ5COgffmxJgnEbki9l2M8Kn5GPcKFgcVRtSm8Ro9cKww4Al01Mw3dN3xqlJQ384Xdaf4csnf
	JQYhIpjCMuUlQ9629GkkZsrdE8eUyIRR5649jIfeEyNWK8oDAv1cQhKSh9fvtzOvpkXEdNfk0k5
	n2OJhI4CpjRcY0GcDcDFYYHKvlsRgXWgZNHwmI3tHWl6cBjEIaY19ftmJO4RHGotAhgrW8lfjSP
	dSZeQh7Vn4/+yhRxdBLs6HoaAmoDEB0k08XFjptmqKdbsxofnLWaE8UxVTN5EP7ErsdWzsyUOmb
	zeUmBmlzFRvfT0up22QXXwkwRwzjv/ANqE8Icc5F9JjeNjryTTqg85i7lHW/a8ivwelM=
X-Received: by 2002:a05:690c:6d83:b0:8b1:6c4d:6b83 with SMTP id
 00721157ae682-8b518f1cf54mr82200347b3.24.1795662783714; Wed, 25 Nov 2026
 19:13:03 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
 <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu> <sashiko-outbox-234405@kernel.org>
 <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
In-Reply-To: <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 26 Nov 2026 11:12:27 +0800
X-Gm-Features: Aa3M54r9bQyCNEtl8vDg0fA8BgkRlMLeLZFLbV6lOjC0bsXV0kG9vz91uifhxJo
Message-ID: <CALOAHbAQuYG__4b054bRobVRyT+v143wBcVAN26T_PtiO-oqmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] livepatch: Include exiting tasks in the transition
To: "Ravindran, Binoy" <binoy@vt.edu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 8:58=E2=80=AFAM Ravindran, Binoy <binoy@vt.edu> wro=
te:
>
>
> Thanks, this is right. A dying task reports its quiescent state in
> rcu_note_context_switch(), early in __schedule(), and then still runs
> traceable code, such as update_rq_clock() and pick_next_task(), until
> switch_to(). RCU does not promise to wait for code after that point, and
> with expedited grace periods the quiescent state is reported right
> there, so synchronize_rcu() can return too early.
> klp_synchronize_transition(), which v2 used, does not have this
> problem: schedule_on_each_cpu() completes only after the work item has
> run on every CPU, which on the dying task's CPU happens only after
> switch_to().
>
> v4 goes back to klp_synchronize_transition() for both waits and keeps
> klp_try_switch_exiting_tasks() from v3. I will send it after rerunning
> the tests.
>
> Yafang, this reverses your second suggestion; I hope the reason above
> makes sense. It also brings back the v2 transition times.

Agreed. I missed the point that the quiescent state is reported early
in __schedule(), and that the code from there until switch_to() is not
covered by synchronize_rcu(). Thanks for pointing that out.

--=20
Regards
Yafang
