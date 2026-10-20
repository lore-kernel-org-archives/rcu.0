Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521660;
	b=TZD2upWOqctVq8CBp7gmzdOkgOmx3n8aolddkljsoex1+CNXtA7GNE7vxDvIwLlHO8GJ
	 yyV3m3DM/aGPijKb+HmU6FKNYwgv721rsw3d/zelC5A+080dEsKmTKDWj/OqHnby1rfut
	 2M/IxaT6VYEOiYdhsIfjZZ9vnWXLy/9QsuhMDT65a6JuiVYVL81Exo+/U9tK8x09FGwS3
	 eOHxxbUlPInyTqsuv0UuuUbnK61lvzF6CCsiNwAeXoau4XHx0oYT83Utbj+6N6iYoKTJz
	 Vaz1yStc5DGnJrXZGkg9MHVJ7kljA3xwb+y0fwOPwxMHh5UYI0hDseJRPDJPcvWjE/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521660;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fZCb5cG4sVLebJJ/gbE7+NG13j0804LxFKEXJHN0iwE=;
	b=OIpo90zW9sJ45HJ0SkT6PTDMWTkPT/HAzk5I1BcttXRsUEnW55beGNUfcsadS9Q11L1s
	 KVPrMhs1hmljqxH1s5jH7uvQr1n2Qv7zshAFMrz+lqHAepziXM/KwBwZhZGKH+aaKxWQC
	 /QpaoWoILmXGeXCsrCs7uQRpYuoRdxfPgvNtOMMy+rO6PJnyAweBJEMVUi9r4dzcYqg72
	 X3rdn1xsb5tULe393wfksqR5yaxxMjc23/zWuNmrrsOTf9OHI+eFPmRY080aX5WmBX1IV
	 S2FsHWIEA2DqzAjNIlJQtHWqqWk1I+qQtIVb1KPQbw4zd61kioWo1pLemrrLwlcumRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b="K8vKS5I/";
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b="R/87C+US";
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1368606A31C;
	Tue, 20 Oct 2026 18:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1368606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=K8vKS5I/;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=R/87C+US
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792521632; bh=fZCb5cG4sVLebJJ/gbE7+NG
	13j0804LxFKEXJHN0iwE=; b=K8vKS5I/wyJ6UQ+AzrL9YnEJB/HE1X1qjVtLSfXUuWTNRpb4Ee
	klnMdYXJLF+6XGvyyail6DqhMmRPJb6WE5fYxxbrJXVpchNSqSlAtczZcbRbZgMI8yQvUjr6S+m
	/KX0t1Z2h3m9rzNbi8lrTxfJ7d9bv+0lSQ0Zlws96R5NYKi4pgEr2KhMBJbRg3w10M5H1mPTZJf
	E1aZyDTvxMeQ6KyAIQEX+ei2VFAjof2EMkkdqmSbPh9PG0+kJlX8zifG/muL+l35P6tkN9ukleo
	mOxf8LqM/MDMjvGBryDNBIAOug+S11vfuOMw+wmx5csPEM6WU5qgo9UizQKIfPz7AKQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792521632; bh=fZCb5cG4sVLebJJ/gbE7+NG
	13j0804LxFKEXJHN0iwE=; b=R/87C+USly3Jz6Se8ZTkm0Yp+BTtvMjfrFezzbcbJJH+J6MhKz
	B3Os/6zMpceO55pbMQuWgZ3CShRWjpS8OlBg==;
Date: Tue, 20 Oct 2026 19:40:31 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>
CC: Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_-rcu/dev=5D_hazptrtorture=3A_Releas?=
 =?US-ASCII?Q?e_all_deferred_hazard_pointers_before_stopping?=
In-Reply-To: <c0540cf0-32ba-46e8-8648-23b70936fde7@paulmck-laptop>
References: <20261019162005.12888-1-parri.andrea@gmail.com> <AFA8DFD1-7D1C-49FD-BE53-95747FE4302C@mainlining.org> <20261019173230.73558-1-parri.andrea@gmail.com> <c0540cf0-32ba-46e8-8648-23b70936fde7@paulmck-laptop>
Message-ID: <5DFD4EE6-3A99-452B-8448-4BBFCBB9402A@mainlining.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 20 October 2026 19:36:47 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Mon, Oct 19, 2026 at 07:32:28PM +0200, Andrea Parri wrote:
>> On Mon, Oct 19, 2026 at 05:22:54PM +0100, Bradley Morgan wrote:
>> > On 19 October 2026 17:20:03 BST, Andrea Parri <parri.andrea@gmail.com>
>> > wrote:
>> 
>> [...]
>> 
>> > >Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred
>hazard pointers")
>> > >Assisted-by: LLM
>> >
>> > Why not put this into a series?
>> 
>> The two patches fix unrelated bugs, touch different files, and apply in
>> either order, so I posted them separately.  But both are for -rcu/dev,
>> and the test notes in the hazptr patch rely on this one.  I'll send the
>> next version as a two-patch series with this patch first, unless Paul
>> prefers separate submissions.
>
>I am fine either way.  But whatever you do, please do *not* put them
>into the same patch.  ;-)
>
>> [...]
>> 
>> > >+	/*
>> > >+	 * Run until hazptr_torture_cleanup() stops this kthread, not just
>> > >+	 * until torture_must_stop(): the writer can be waiting in ->sync()
>> > >+	 * for a deferred hazard pointer while it is being stopped.
>> > >+	 */
>> >
>> > Could this be shorter?
>> 
>> Yes.  The comment in hazptr_torture_cleanup() already says why, so this
>> one can just point there:
>> 
>> 	/* Keep going until hazptr_torture_cleanup() stops us, see there. */
>> 
>> [...]
>
>The longer one is better.
>
>> > >+	/* The readers have stopped, so nothing new can be deferred. */
>> > >+	for_each_possible_cpu(cpu)
>> >
>> > Is the comment needed? I don't know if it's nessesary.
>> 
>> I'd keep it.  A reader can defer after the last pass in the loop, and
>> kthread_stop() can then end the loop without another pass, so this
>> pass is needed; the comment says why one pass is enough.
>> 
>> > >+	/*
>> > >+	 * Stop do_pending only after the writer and the readers: the writer
>> > >+	 * may be waiting on hazard pointers that readers deferred.
>> > >+	 */
>> >
>> > May we shorten this? Feel free to bikeshed that one.
>> 
>> Sure:
>> 
>> 	/* The writer may wait on hazard pointers that readers deferred. */
>
>And same here.
>
>I am sure that it is possible to create shorter versions that keep all
>to the information, but I am OK with Andrea's original versions.
>
>Bradley, Andrea is not a native English speaker and I believe that
>you are, so if you want better wording here, please provide it to him.
>Perhaps someday he will return the favor should you ever be required to
>write in Italian (or German or Ladin, for that matter).  ;-)

Well, or he could be my language teacher :)

Yeah, if those don't need to be accounted for, I'm fine with this :D

Acked-by: Bradley Morgan <brads@mainlining.org>

>
>							Thanx, Paul
>
>> Thanks for the review,
>>   Andrea


--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
