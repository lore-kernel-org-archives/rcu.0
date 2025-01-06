Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B90A936;
	Mon,  6 Jan 2025 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736145500; cv=none; b=qbG0rgMxXjzD/n0HriZ2AQzvZBDnUewOiAfTWPP7rS1TRM6K3oK9wocIEC5HiV//OnM9/MdHa6uKIsO+jziL0ikz59ElHK3ud4IwWGxaQ4id9xn2+WTeFoPsiW+aaV1tuheFwe+j8L/T+ptqx7HzBRmZKQ8dAmkWRmYMHnYJ7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736145500; c=relaxed/simple;
	bh=EBScPS4uiqxoxIgiASUpgFfUQ3Bql6pT8IGUKwMZz5E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=r6s0nrJ4qDTpFJK3JsDmBbenGIE9cKf4cgZwDmP9tac4Ga0mJYQQQZ8zQEzzuhnLn5BXTW+nMNCg54zjl6gQ0pVXZAkyXJmkGkJrG3aZV4KFfHCA1Ts4G4gf4kA/zLOAk5fbxfIUGDRXqAw5U90Y7FJTRdDXpoZr/R8r0niFd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=U5/Oi3a4; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="U5/Oi3a4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736145457;
	bh=hkFtlu1OQRd+v0luNlpf6Yypzj0ZLV+0QNVPanIiJ84=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=U5/Oi3a4AXRsLZ4THDaStvDj1DLguehRZ1qKQWo8G+9pEOduHYrS0pNs5UfdHDi0R
	 t1TtiJ6xcZEeTEeJ/6YarCI0ZDDKc+16qy5SjNGPcBLWKxoM15F9SeU7pePEw3Iusm
	 gUSNO/+RgpMs9y52v5L8Jp8/Ose6RFJ93PfuRA7s=
X-QQ-mid: bizesmtpip4t1736145451t4sqaru
X-QQ-Originating-IP: iobbV2B3JEdanX9Mwyw/pj6kCRP2kOWngGDBaPalyFU=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jan 2025 14:37:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13212943590366801547
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: watchdog: BUG: soft lockup in note_gp_changes in
 kernel/rcu/tree.c
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <67fafa6f-57e2-48b9-a181-98e5ac37cbe5@paulmck-laptop>
Date: Mon, 6 Jan 2025 14:37:18 +0800
Cc: frederic@kernel.org,
 neeraj.upadhyay@kernel.org,
 joel@joelfernandes.org,
 josh@joshtriplett.org,
 boqun.feng@gmail.com,
 urezki@gmail.com,
 rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com,
 rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B6C255A-4F2D-4928-BF9D-17F7E3C4BA3E@m.fudan.edu.cn>
References: <7238787A-B616-4E0C-85DF-DB17012FA1C0@m.fudan.edu.cn>
 <67fafa6f-57e2-48b9-a181-98e5ac37cbe5@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NlWvLSkfVnGcUghOBtbu9aXrM2tmyVcIJ6uw7ctmBsqiW/J363iugTXM
	WvLsvyVZS8Ykhpa3d13rt9qDo4BC5P23kCtJHj+Tefi3YQyMKRURBdrI9leQ3L01qDwAmNP
	ZcWarfyx1MU/eHyXO+yS3PaHewIHL51xgsW6PCVprFOZp3NuukLoJj1RI+VxA+wbgvLcFDu
	Ej2wqmGfdYUH8bJzoxpnzlsvXf0EsFQlfN47s8LfBFwNzZMG84P20WFf/Zh75Db5KdTRHCT
	KRz0q1Y5GAMdWWkytBc66onFq7Aj11d0iiNqCvADdKmco+oS6HtgtPhwX2Dujez21GxULuu
	k209YnBj9N4Ux1eLM3WSjMGq6cfQD5grktTktseC7txJGSoSguVu1Q0OHxTXQB857aGDsOo
	QFpFBE+a9ewt0Kcz/PRq5s3qFsm5QWpOlALJubs2NOVEkcRSwUX510XM3WLHx//dcwSOfHJ
	dLSCLI+IpusqqxhJch8hvBJNA1tQiIZ0N0QgwHjdP2rYRanJI6C9g5PjE3OGfP0zwSbAKHK
	BuYzmx0kujyAGmvn239+1jSAUxheOfilZ53skE5eiEaUD20VS9skhYy1zqGA/PljQCAK/oh
	NZiIxvk0p6XRTjPkPX7Qhqz7Gi6dLAiu8WmCOYoMmx+aGASdjvZbUa2a7BWFLQAKg8ubYD7
	eY29CdOnlJSYaHBkb5bYKMpCzMnUqOjZHZTocFeJJzuGZKTWyrs8FVRKblRHwqhPt8tVV3K
	zz7LL8qaseAqqYj03eEap5/Q246Wb45FE4soBbzvIJpUIaEmJLYWWkPQZiiufg+onpuBTnV
	ruzoEnQq9qoi1PajFHWAzL1OiI4+PT1BquZgGWSjUy2VclrJF3TBIzhVOhM0DkAW7q+/Ho1
	E8J/IoIO0kltBhopFKEup1L6pSz1tpAsZzhbvUqXUwhG55/EXI3z6CzOS7Zqj/pwviKEr7Z
	PHWPcxGci36AWlcAj6blaaVY8XDdPCatxGVog12N36gMgidKRFrLh8umK
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B41=E6=9C=883=E6=97=A5 08:16=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jan 02, 2025 at 10:59:27AM +0800, Kun Hu wrote:
>> Hello,
>>=20
>> When using our customed fuzzer tool to fuzz the latest Linux kernel, =
the following crash
>> was triggered.
>>=20
>> HEAD commit: dbfac60febfa806abb2d384cb6441e77335d2799
>> git tree: upstream
>> Console output: =
https://drive.google.com/file/d/1D3EDxDxPi0t7m_Z4Uc4FuL26DnHs7yTa/view?usp=
=3Dsharing
>> Kernel config: =
https://drive.google.com/file/d/1m1mk_YusR-tyusNHFuRbzdj8KUzhkeHC/view?usp=
=3Dsharing
>> C reproducer: /
>> Syzlang reproducer: /
>>=20
>> We observed a crash at line 1333 in note_gp_changes, likely caused by =
a race condition involving rcu_gp_kthread_wake and note_gp_changes. The =
issue appears to involve insufficient or incorrect synchronization, as =
indicated by the involvement of _raw_spin_unlock_irqrestore in =
spinlock.c. Specifically, this may lead to invalid accesses to =
rcu_state.gp_kthread or related flags (e.g., gp_flags), potentially =
resulting in unexpected behavior in swake_up_one_online.
>>=20
>> Could you please help check if this needs to be addressed?
>=20
> This is a new one on me.
>=20
> This is running in a guest OS.  Might the underlying hypervisor be
> overloaded?  That could result in vCPU preemption and thus in this =
sort
> of soft lockup.
>=20
> Also, when I check out the above commit (which is v6.13-rc4), I find =
that
> line 1333 is the close curly brace of note_gp_changes().  Of course, =
it is
> possible that the address-to-symbol translation failed (please =
check!),
> but in the absence of such failure, there is no way that I know of =
that
> incorrect synchronization could cause a soft lockup at that location.
>=20
> Other things besides vCPU preemption that could cause a soft lockup at
> that location include corrupted kernel text, corrupted kernel stack,
> and incessant interrupts.
>=20
> Other thoughts?
>=20
> Thanx, Paul
>=20

Sorry for late,=20

I double-checked that it's not the address-to-symbol translation =
failing, and the vCPU resources aren't overloaded. Additionally, I tried =
to reproduce multiple rounds using Syzkaller to get two types of =
reproducers, c and syscall sequences. i'm not sure if there are any =
other issues, that's all I can offer for now.

Not sure if this information is useful to you, if it really isn't a real =
bug, please ignore it.

C reproducer: =
https://drive.google.com/file/d/1niejFamwXcRumUsn1Ur8xiX2jfZAcown/view?usp=
=3Dsharing
Syscall sequence reproducer: =
https://drive.google.com/file/d/1gBfe_WZZeHfrhTlXp5zJfV7be21iGCAC/view?usp=
=3Dsharing
New log info: =
https://drive.google.com/file/d/1x7eugPh2RUUF9lOf3s9K64pARkkUE1Qn/view?usp=
=3Dsharing

----
Thanks,
Kun Hu=
